class ConfirmationEmailPage < Howitzer::Web::Page
  url '/users/confirmation?confirmation_token={token}'
  validate :url, /\/users\/confirmation/

end
