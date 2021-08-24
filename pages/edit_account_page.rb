require_relative 'demo_app_page'
class EditAccountPage < DemoAppPage
  path '/users/edit'
  validate :title, /Demo web application - Edit User\z/
  section :errors

  element :cancel_account_button, :button, 'Cancel my account'
  element :update_account_btn, :button, 'Update'
  element :name, :fillable_field, 'user_name'
  element :email, :fillable_field, 'user_email'
  element :password, :fillable_field, 'user_password'
  element :password_confirmation, :fillable_field, 'user_password_confirmation'
  element :current_password, :fillable_field, 'user_current_password'

  def cancel_my_account
    Howitzer::Log.info 'Cancelling user account'
    accept_js_confirmation do
      cancel_account_button_element.click
    end
  end

  def fill_form(user_name: '', email: '', password: '', password_confirmation: '', current_password: '')
    Howitzer::Log.info "Fill in Edit Account form with data:\n\tuser_name: #{user_name}\n\temail: #{email}\n" \
                       "\tpassword: #{password}\n\tpassword_confirmation: #{password_confirmation}\n" \
                       "\tcurrent_password: #{current_password}"
    name_element.set(user_name)
    email_element.set(email)
    password_element.set(password)
    password_confirmation_element.set(password_confirmation)
    current_password_element.set(current_password)
    self
  end

  def submit_form
    Howitzer::Log.info 'Update user account'
    update_account_btn_element.click
  end

  def form_data
    { user_name: name_element.value,
      email: email_element.value,
      password: password_element.value,
      password_confirmation: password_confirmation_element.value,
      current_password: current_password_element.value }
  end
end
