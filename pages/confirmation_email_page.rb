class ConfirmationEmailPage < Howitzer::Web::Page
  url '/users/confirmation?confirmation_token={token}'
  validate :url, /\/users\/confirmation/

  #TODO remove it when new :open method without validation will be implemented
  def self.given; end
end
