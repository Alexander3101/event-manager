require 'rails_helper'
Capybara.default_driver = :selenium

RSpec.describe "EVENTS tests", :type => :feature do
  it "shows all current or coming soon events on index", js: true do
    visit events_path
    expect(page).to have_content("События:")
    events = Event.where('end_datetime > ?', DateTime.now).count
    expect(page.source.should have_css('.my', :count => events))
  end

  it "has page for each event", js: true do
    events = Event.all
    events.each do |event|
      visit events_path + "/#{event.id}"
      expect(page).to have_content(event.title)
    end
  end

  it "has correct links for each event on index page", js: true do
    visit events_path
    lis = page.find_all(".my")
    lis.each do |li|
      event = page.find(:xpath, "#{li.path}/a")
      expect(event[:href]=="#{events_path}/#{event[:id]}")
    end
  end

  it "has all required attributes shown on event page", js: true do
    event = Events.first
    visit "#{events_path}/#{event[:id]}"
    expect(page).to have_content("Время проведения")
    expect(page).to have_content("Создатель")
    expect(page).to have_content("Комнаты")
    expect(page).to have_content(event.title)
  end
end
