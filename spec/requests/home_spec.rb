require 'rails_helper'
Capybara.default_driver = :selenium

RSpec.describe "HOME PAGE tests", :type => :feature do
  describe "navbar" do
    it "should has a navigation bar with Rooms, Events and Home links", js: true do
      visit root_path
      page.should have_link("Главная", :href=>"/", :class=>"navbar-brand")
      page.should have_link("События", :href=>"/events")
      page.should have_link("Комнаты", :href=>"/rooms")
    end

    it "goes to /events when Events button pressed", js: true do
      visit root_path
      click_link("События")
      expect(page).to have_current_path("/events")
    end

    it "goes to /rooms when Rooms button pressed", js: true do
      visit root_path
      click_link("Комнаты")
      expect(page).to have_current_path("/rooms")
    end

    it "has login button", js: true do
      visit root_path
      page.should have_link('Войти')
    end
  end
  describe "content" do
    it "should have 10 nearest events or less", js: true do
      visit root_path
      expect(page.source.should have_css('.my', :between => 0..10))
    end
  end

end
