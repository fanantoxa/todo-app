require 'features_helper'

describe 'Registration page.', js: true do
  let(:registration_page) { Todo::RegistrationPage.new }
  let(:login_page) { Todo::LoginPage.new }
  let(:projects_page) { Todo::ProjectsPage.new }

  before do
    @page = registration_page
    @page.load
  end

  feature 'I want be able to see registration form' do

    scenario 'displayed' do
      expect(@page).to have_email
      expect(@page).to have_password
      expect(@page).to have_password_confirmation
      expect(@page).to have_registration_btn
      expect(@page).to have_login_link
      expect(@page).to have_no_errors
    end

    scenario 'and go to login page' do
      @page.login_link.click
      expect(login_page).to be_displayed
    end
  end

  feature 'I want be able create a new customer' do
    let(:not_exist_user) { FactoryGirl.build :not_exist_user }

    scenario 'and redirect to project page' do
      @page.register(not_exist_user)
      expect(projects_page).to be_displayed
    end
  end
  
  feature 'I want see validation error' do
    let(:not_valid_user) { FactoryGirl.build :not_valid_user }

    before do
      @page.register(not_valid_user)
    end

    scenario 'with wrong email message' do
      expect(@page).to have_content 'Field can\'t be blank'
    end

    scenario 'with short password message' do
      expect(@page).to have_content 'Field is too short (minimum is 8 characters)'
    end

    scenario 'with short password confirm. not mismatch message' do
      expect(@page).to have_content 'Field doesn\'t match Password'
    end
  end
end