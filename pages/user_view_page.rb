require_relative 'demo_app_page'
class UserViewPage < DemoAppPage
  url '/users'
  validate :title, /\ADemo web application - User\z/
end
