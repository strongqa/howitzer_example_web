require_relative 'demo_app_page'
class UsersPage < DemoAppPage
  path '/users'
  validate :title, /\ADemo web application - Users\z/

  element :user_row_data, :xpath, ->(email) { ".//*[contains(@class, 'users__item')][contains(., '#{email}')]" }
  element :user_cell_data, :xpath, ".//div[contains(.,'Created at:')]"
  element :user_name, :link_or_button, ->(name) { name }

  def open_user(user_name)
    Howitzer::Log.info "Open user '#{user_name}' page"
    user_name_element(user_name).click
  end

  def user_registration_date(email)
    within_user_row_data_element(email) { user_cell_data_element.text }
  end
end
