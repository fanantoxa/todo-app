require 'features_helper'

describe 'Login page.', js: true do
  let(:login_page) { Todo::LoginPage.new }
  let(:registration_page) { Todo::RegistrationPage.new }
  let(:projects_page) { Todo::ProjectsPage.new }

  before do
    @page = login_page
    @page.load
  end

  feature 'I want be able to see log in form' do

    scenario 'displayed' do
      expect(@page).to have_email
      expect(@page).to have_password
      expect(@page).to have_login_btn
      expect(@page).to have_no_errors
      expect(@page).to have_registration_link
    end

    scenario 'and go to registration page' do
      @page.registration_link.click
      expect(registration_page).to be_displayed
    end
  end

  feature 'I want be able to log in with form' do
    let(:user) { FactoryGirl.build :user }
    let(:not_exist_user) { FactoryGirl.build :not_exist_user }

    scenario 'to existing customer' do
      @page.login_as(user)
      expect(projects_page).to be_displayed
    end

    scenario 'and see errors for not exist customer' do
      @page.login_as(not_exist_user)
      expect(@page).to have_errors
    end
  end
end