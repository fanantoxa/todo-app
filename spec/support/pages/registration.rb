module Todo
  class RegistrationPage < SitePrism::Page
    set_url '#/registration'

    element :email,                   '#email'
    element :password,                '#password'
    element :password_confirmation,   '#password_confirmation'
    element :registration_btn,        '#registration_btn'
    element :login_link,              '.login_link'
    elements :errors,                 '.errors'

    def register user
      email.set user.email
      password.set user.password
      password_confirmation.set user.password_confirmation
      registration_btn.click
    end
  end
end