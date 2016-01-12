require 'features_helper'

describe 'Index page.', js: true do
  let(:index_page) { Todo::IndexPage.new }
  let(:login_page) { Todo::LoginPage.new }

  feature 'I want be redirected to login page if I am not logged in' do

    scenario "visited with new session" do
      index_page.load
      expect(login_page).to be_displayed
    end
  end

  feature 'I want be redirected to projects page if I am logged in' do
    let(:projects_page) { Todo::ProjectsPage.new }
    let(:user) { FactoryGirl.create :user }

    scenario "visited with old session" do
      index_page.load
      login_page.wait_until_email_visible
      login_page.login_as user
      projects_page.wait_until_projects_visible
      index_page.load
      expect(projects_page).to be_displayed
    end
  end
end