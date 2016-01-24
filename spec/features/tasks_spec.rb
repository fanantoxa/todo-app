require 'features_helper'

describe 'Tasks page.', features: true, js: true do
  let(:login_page) { Todo::LoginPage.new }
  let(:projects_page) { Todo::ProjectsPage.new }
  let(:user) { FactoryGirl.create :user }

  before do
    @project = FactoryGirl.create :project, user: user
    @task_1 = FactoryGirl.create :task, project: @project
    @task_2 = FactoryGirl.create :task, project: @project
    login_page.load
    login_page.login_as user
    projects_page.wait_until_list_visible
    @first_project = projects_page.list.first
    projects_page.list.first.wait_until_task_list_visible
  end

  feature 'I want be able to see from for adding task' do
    scenario 'displayed' do
      expect(@first_project.task_form).to have_name
      expect(@first_project.task_form).to have_add_btn
    end
  end

  feature 'I want be able to see already created tasks' do
    before do
      @first_task_item = @first_project.task_list.first
    end
    
    scenario 'should be presented with already creadted task' do
      expect(@first_project).to have_task_list count: 2, wait: 5

      expect(@first_task_item).to have_item_name
      expect(@first_task_item.item_name).to have_content @task_1.name

      expect(@first_task_item).to have_item_status
      expect(@first_task_item.item_status.checked?).to eq @task_1.status

      expect(@first_task_item).to have_item_date
      expect(@first_task_item).to have_no_item_date_icon
      expect(@first_task_item.item_date).to have_content @task_1.due_date.strftime('%d-%m-%Y')

      expect(@first_task_item).to have_item_edit_btn
      expect(@first_task_item).to have_item_delete_btn
      expect(@first_task_item).to have_item_comments_btn
    end
  end

  feature 'I want be able add tasks' do
    let(:new_task) { FactoryGirl.build :task }

    scenario 'successful' do
      @first_project.task_form.add_new new_task
      expect(@first_project).to have_task_list count: 3, wait: 2
    end

    scenario 'with error'
  end


  feature 'I want be able edit tasks' do
    before do
      @first_task_item = @first_project.task_list.first
    end

    feature 'edit name' do
      feature 'start editing' do
        scenario 'with button' do
          @first_task_item.item_edit_btn.click
          expect(@first_task_item).to have_form_name
          expect(@first_task_item).to have_no_item
        end

        scenario 'with double click' do
          @first_task_item.item_name.double_click
          expect(@first_task_item).to have_form_name    
          expect(@first_task_item).to have_no_item
        end
      end

      feature 'finish editing' do
        before do
          @first_task_item.item_edit_btn.click
          @first_task_item.form_name.set 'sone another text'
        end

        scenario 'with button' do
          @first_task_item.form_apply_btn.click
          expect(@first_task_item.item_name).to have_content 'sone another text'
        end

        scenario 'with ENTER key' do
          @first_task_item.form_name.send_keys :enter
          expect(@first_task_item.item_name).to have_content 'sone another text'
        end
      end

      feature 'cancel editing' do
        before do
          @first_task_item.item_edit_btn.click
          @first_task_item.form_name.set 'sone another text'
        end

        scenario 'with button' do
          expect(@first_task_item).to have_form_name
          expect(@first_task_item).to have_no_item
          @first_task_item.form_cancel_btn.click
          @first_task_item = @first_project.task_list.first
          expect(@first_task_item).to have_no_form_name
          expect(@first_task_item).to have_item
          expect(@first_task_item.item_name).to have_content @task_1.name
        end

        scenario 'with ESC key' do
          expect(@first_task_item).to have_form_name
          expect(@first_task_item).to have_no_item
          @first_task_item.form_name.send_keys :escape
          @first_task_item = @first_project.task_list.first
          expect(@first_task_item).to have_no_form_name
          expect(@first_task_item).to have_item
          expect(@first_task_item.item_name).to have_content @task_1.name
        end
      end
    end

    feature 'edit status' do
      before do
        check @first_task_item.item_status
      end
      
      xscenario 'set complited' do
        expect(@first_task_item.item_status.checked?).to eq !@task_1.status
      end

      xscenario 'unset complited' do
        expect(@first_task_item.item_status.checked?).to eq !@task_1.status
        uncheck @first_task_item.item_status
        expect(@first_task_item.item_status.checked?).to eq @task_1.status
      end
    end

    feature 'due_date' do
      scenario 'set date'
      scenario 'clear date'
    end

    feature 'edit position' do
      scenario 'move task down'
      scenario 'move task up'
    end
  end

  feature 'I want be able remove projects' do
    scenario 'successful' do
      @first_project.task_list.first.item_delete_btn.click
      expect(@first_project).to have_task_list count: 1, wait: 5
    end
  end
end