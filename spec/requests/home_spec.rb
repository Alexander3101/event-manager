require 'rails_helper'
Capybara.default_driver = :selenium

RSpec.describe "HOME", :type => :feature do
  describe "GET /" do
    it "works!", js: true do
      visit '/'
      page.should have_content('О сервисе')
    end
  end
end
