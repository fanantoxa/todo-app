module Todo
  class LoginPage < SitePrism::Page
    set_url '#/login'

    element :email,      '#email'
    element :password,   '#password'
    element :login_btn,  '#login_btn'


    def login_as user
      email.set user.email
      password.set user.password
      login_btn.click
    end
  end
end