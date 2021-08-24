require_relative 'demo_app_page'
class ChangePasswordPage < DemoAppPage
  path '/users/password/edit?reset_password_token={token}'
  validate :url, %r{/users/password(?:\z|/edit)}

  element :password_input, :fillable_field, 'user_password'
  element :confirm_password_input, :fillable_field, 'user_password_confirmation'
  element :submit_form, :button, 'Change my password'
  element :alert_text, '#error_explanation'

  def fill_form(new_password: nil, confirm_new_password: nil)
    Howitzer::Log.info "Fill in Change Password form with new password: '#{new_password}'"
    password_input_element.set(new_password) unless new_password.nil?
    confirm_password_input_element.set(confirm_new_password) unless confirm_new_password.nil?
    self
  end

  def submit_form
    Howitzer::Log.info 'Submit Change Password form'
    submit_form_element.click
  end
end
