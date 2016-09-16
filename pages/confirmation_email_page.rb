require_relative 'demo_app_page'
class ConfirmationEmailPage < DemoAppPage
  path '/users/confirmation?confirmation_token={token}'
  validate :url, %r{\/users\/confirmation}
end
