require_relative 'demo_app_page'
class UsersPage < DemoAppPage
  url '/users'
  validate :title, /\ADemo web application - Users\z/

  element :registered_user_date, :xpath, ->(email) { ".//li[contains(.,'#{email}')]" }
  element :user_email, :link_or_button, ->(email) { email }

  def open_user(user_email)
    log.info "Open user '#{user_email}' page"
    user_email_element(user_email).click
  end

  def user_registration_date(email)
    registered_user_date_element(email).text
  end
end
