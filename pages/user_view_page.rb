require_relative 'demo_app_page'
class UserViewPage < DemoAppPage
  path '/users'
  validate :title, /\ADemo web application - User .+\z/
end
