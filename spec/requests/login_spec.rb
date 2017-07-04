require 'rails_helper'
Capybara.default_driver = :selenium

RSpec.describe "LOGIN MODAL WINDOW tests", :type => :feature do
  describe "content" do

    it "shows login modal window after pressing login button", js: true do
      visit root_path
      click_on("Войти")
      within(".modal-content") do
        page.should have_content('Email')
        page.should have_xpath(".//input[@id='user_email']")

        page.should have_content('Пароль')
        page.should have_xpath(".//input[@id='user_password']")

        page.should have_xpath(".//input[@type='submit']")
      end
    end

    def login!(login, password)
      visit root_path
      click_on("Войти")
      within(".modal-content") do
        fill_in 'user_email', with: login
        fill_in 'user_password', with: password
        page.find(:xpath, '//input[@type="submit"]').click
      end
    end

    it "logins", js: true do
      login!("admin@admins.net", "admin2")
      expect(page).to have_current_path(root_path)
      expect(page).to have_link("Выйти")
      expect(page).to have_link("Личный кабинет")
    end
  end

end
