require_relative 'demo_app_page'
class UserViewPage < DemoAppPage
  path '/users/{/id}'
  validate :url, %r{/users/\d+\z}
end
