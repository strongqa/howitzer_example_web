require_relative 'demo_app_page'
class UsersPage < DemoAppPage
  path '/users'
  validate :title, /\ADemo web application - Users\z/

  element :registered_user_date, :xpath,
          ->(email) { %(//a[contains(.,"#{email}")]/ancestor::div[contains(.,"Created at: ")][1]) }
  element :user_name, :link_or_button, ->(name) { name }

  def open_user(user_name)
    Howitzer::Log.info "Open user '#{user_name}' page"
    user_name_element(user_name).click
  end

  def user_registration_date(email)
    registered_user_date_element(email).text
  end
end
