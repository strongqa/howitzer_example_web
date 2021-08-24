require_relative 'demo_app_page'
class SearchPage < DemoAppPage
  validate :url, %r{/search\?utf8=(.+)?\z}

  element :article, :xpath, ->(name) { "//section[@class='article__item']//a[contains(text(),'#{name}')]" }
end
