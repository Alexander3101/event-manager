require 'rails_helper'
include LoginHelper
Capybara.default_driver = :selenium

RSpec.describe "LOGIN/LOGOUT MODAL WINDOW tests", :type => :feature do
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

  it "logins and logouts from root_path", js: true do
    visit root_path
    login!("admin@admins.net", "admin2")

    expect(page).to have_current_path(root_path)
    expect(page).to have_link("Выйти")
    expect(page).to have_link("Личный кабинет")

    click_on("Выйти")
    expect(page).to have_current_path(root_path)
  end

  it "logins/logouts from events_path", js: true do
    visit events_path
    login!("admin@admins.net", "admin2")

    expect(page).to have_current_path(events_path)
    expect(page).to have_link("Выйти")
    expect(page).to have_link("Личный кабинет")

    click_on("Выйти")
    expect(page).to have_current_path(root_path)
  end

  it "logins/logouts from rooms_path", js: true do
    visit rooms_path
    login!("admin@admins.net", "admin2")

    expect(page).to have_current_path(rooms_path)
    expect(page).to have_link("Выйти")
    expect(page).to have_link("Личный кабинет")

    click_on("Выйти")
    expect(page).to have_current_path(root_path)
  end

  it "has profile and can logout from profile page", js: true do
    visit root_path
    login!("admin@admins.net", "admin2")

    click_on("Личный кабинет")
    expect(page).to have_current_path("/users/" + (User.find_by email: "admin@admins.net")[:id].to_s)

    click_on("Выйти")
    expect(page).to have_current_path(root_path)
  end

end
