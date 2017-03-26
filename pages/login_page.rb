require_relative 'demo_app_page'
class LoginPage < DemoAppPage
  path '/users/sign_in'
  validate :title, /\ADemo web application - Log In\z/
  validate :url, %r{\/sign_in\/?\z}

  element :email_input, :fillable_field, 'user_email'
  element :password_input, :fillable_field, 'user_password'
  element :remember_me, :checkbox, 'user_remember_me'
  element :login_btn, '[name=commit]'

  element :sign_up_link, :link, 'new_user_sign_up'
  element :forgot_password_link, :link, 'Forgot password?'

  def fill_form(email: nil, password: nil, remember_me: nil)
    Howitzer::Log.info 'Fill in Login Form with data:' \
               "email: #{email}, password: #{password}, remember_me: #{remember_me}"
    email_input_element.set(email) unless email.nil?
    password_input_element.set(password) unless password.nil?
    remember_me_element.set(true) unless remember_me.nil?
    self
  end

  def submit_form
    Howitzer::Log.info 'Submit Login Form'
    login_btn_element.click
  end

  def login_as(email, password, remember_me = false)
    Howitzer::Log.info "Login with: Email=#{email}, Password=#{password}, Remember Me=#{remember_me}"
    fill_form(email: email, password: password, remember_me: remember_me)
    submit_form
    HomePage.given
  end

  def navigate_to_forgot_password_page
    Howitzer::Log.info 'Navigate to forgot password page'
    forgot_password_link_element.click
  end
end
