require_relative 'demo_app_page'
class ForgotPasswordPage < DemoAppPage
  url '/users/password/new'
  validate :url, %r{\/users\/password}

  element :email_input, :fillable_field, 'user_email'
  element :reset_password_button, :button, 'Reset Password'

  def fill_form(email: nil)
    Howitzer::Log.info "Fill in Forgot Password form with email: #{email}"
    email_input_element.set(email) unless email.nil?
    self
  end

  def submit_form
    Howitzer::Log.info 'Submit Forgot Password form'
    reset_password_button_element.click
  end
end
