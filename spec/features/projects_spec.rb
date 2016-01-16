require 'features_helper'

describe 'Projects page.', features: true, js: true do
  let(:login_page) { Todo::LoginPage.new }
  let(:projects_page) { Todo::ProjectsPage.new }
  let(:user) { FactoryGirl.create :user }
  
  before do
    @project = FactoryGirl.create :project, user: user
    login_page.load
    login_page.login_as user
    projects_page.wait_until_list_visible
  end

  feature 'I want be able to see from for adding project' do

    scenario 'displayed' do
      expect(projects_page.form).to have_name
      expect(projects_page.form).to have_add_btn
    end
  end

  feature 'I want be able to see already created projects' do
    before do
      @project_item = projects_page.list[0]
    end

    scenario 'should be presented with already creadted projects' do
      expect(projects_page).to have_list count: 1
      expect(@project_item).to have_item_edit_btn
      expect(@project_item.item_name).to have_content @project.name
    end
  end

  feature 'I want be able add projects' do
    let(:new_project) { FactoryGirl.build :project }

    scenario 'successful' do
      projects_page.add_new new_project
      expect(projects_page).to have_list count: 2, wait: 2
    end

    scenario 'with error'
  end

  feature 'I want be able edit projects' do
    before do
      @project_item = projects_page.list[0]
    end

    feature 'start editing' do
      scenario 'with button' do
        @project_item.item_edit_btn.click
        expect(@project_item).to have_form_name
        expect(@project_item).to have_no_item
      end

      scenario 'with double click' do
        @project_item.item_name.double_click
        expect(@project_item).to have_form_name    
        expect(@project_item).to have_no_item
      end
    end

    feature 'finish editing' do
      before do
        @project_item = projects_page.list[0]
        @project_item.item_edit_btn.click
        @project_item.form_name.set 'sone another text'
      end

      scenario 'with button' do
        @project_item.form_apply_btn.click
        expect(@project_item.item_name).to have_content 'sone another text'
      end

      scenario 'with ENTER key' do
        @project_item.form_name.send_keys :enter
        expect(@project_item.item_name).to have_content 'sone another text'
      end
    end

    feature 'cancel editing' do
      before do
        @project_item = projects_page.list[0]
        @project_item.item_edit_btn.click
        @project_item.form_name.set 'sone another text'
      end

      scenario 'with button' do
        expect(@project_item).to have_form_name
        expect(@project_item).to have_no_item
        @project_item.form_cancel_btn.click
        @project_item = projects_page.list[0]
        expect(@project_item).to have_no_form_name
        expect(@project_item).to have_item
        expect(@project_item.item_name).to have_content @project.name
      end

      scenario 'with ESC key' do
        expect(@project_item).to have_form_name
        expect(@project_item).to have_no_item
        @project_item.form_name.send_keys :escape
        @project_item = projects_page.list[0]
        expect(@project_item).to have_no_form_name
        expect(@project_item).to have_item
        expect(@project_item.item_name).to have_content @project.name
      end
    end
  end

  feature 'I want be able remove projects' do
    scenario 'successful' do
      projects_page.list[0].item_delete_btn.click
      expect(projects_page).to have_list count: 0, wait: 2
    end
  end
end