require_relative 'demo_app_page'
class ConfirmationEmailPage < DemoAppPage
  url '/users/confirmation?confirmation_token={token}'
  validate :url, /\/users\/confirmation/

end
