module Todo
  class RegistrationPage < SitePrism::Page
    set_url '#/registration'

    element :email,                   '#email'
    element :password,                '#password'
    element :password_confirmation,   '#password_confirmation'
    element :registration_btn,        '#registration_btn'
    element :login_link,              '.login_link'
  end
end