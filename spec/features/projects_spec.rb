require 'features_helper'

describe 'Projects page.', features: true, js: true do
  let(:login_page) { Todo::LoginPage.new }
  let(:projects_page) { Todo::ProjectsPage.new }
  let(:user) { FactoryGirl.create :user }
  
  before do
    @project = FactoryGirl.create :project, user: user
    login_page.load
    login_page.login_as user
    projects_page.wait_until_projects_visible
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
      expect(projects_page.list.count).to eq 1
      expect(@project_item).to have_item_edit_btn
      expect(@project_item.item_name).to have_content @project.name
    end
  end

  feature 'I want be able add projects' do
    let(:new_project) { FactoryGirl.build :project }

    scenario 'successful' do
      projects_page.add_new new_project
      wait_for_ajax
      expect(projects_page.list.count).to eq 2
    end

    scenario 'with error'
  end

  feature 'I want be able edit projects' do
    feature 'finish editing' do
      xscenario 'with button' do
      end

      xscenario 'with ENTER key' do
      end
    end

    feature 'cancel editing' do
      xscenario 'with button' do
      end

      xscenario 'with ESC key' do
      end
    end
  end

  feature 'I want be able remove projects' do
    scenario 'remove new project'
    scenario 'remove already created project'
  end
end