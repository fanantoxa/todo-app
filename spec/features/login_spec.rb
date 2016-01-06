require 'features_helper'

describe 'Login page.', js: true do
  let(:login_page) { Todo::LoginPage.new }
  let(:registration_page) { Todo::RegistrationPage.new }
  let(:projects_page) { Todo::ProjectsPage.new }

  before do
    @page = login_page
    @page.load
  end

  feature 'I want be able to log in with form' do
    let(:user) { FactoryGirl.build :user }
    let(:not_exit_user) { FactoryGirl.build :not_exit_user }

    scenario 'to existing customer' do
      @page.login_as(user)
      expect(projects_page).to be_displayed
    end

    scenario 'and see errors for not exist customer' do
      @page.login_as(not_exit_user)
      expect(@page).to have_errors
    end

    scenario 'and gor to registration page' do
      expect(@page).to have_registration_link
      @page.registration_link.click
      expect(registration_page).to be_displayed
    end
  end
end