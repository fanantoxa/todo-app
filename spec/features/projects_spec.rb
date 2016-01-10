require 'features_helper'

describe 'Projects page.', js: true do
  let(:login_page) { Todo::LoginPage.new }
  let(:projects_page) { Todo::ProjectsPage.new }

  feature 'I want be able to see from for adding project' do
    let(:user) { FactoryGirl.build :user }

    before do
      login_page.load
      login_page.login_as(user)
      @project_form = projects_page.project_form
    end

    scenario 'displayed' do
      expect(@project_form).to have_name
      expect(@project_form).to have_add_btn
    end
  end

  feature 'I want be able to see already created projects' do
    scenario 'should be presented with already creadted projects'
  end

  feature 'I want be able add projects' do
    scenario 'and add one project'
    scenario 'and add few projects'
  end

  feature 'I want be able edit projects' do 
    scenario 'edit created project'
  end

  feature 'I want be able remove projects' do
    scenario 'remove new project'
    scenario 'remove already created project'
  end
end