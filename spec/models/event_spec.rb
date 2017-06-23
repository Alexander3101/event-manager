require 'rails_helper'

RSpec.describe Event, type: :model do
  describe ".new" do

    it "is valid with valid attributes" do
       expect(
        Event.new(
          title: "Test_event",
          begin_datetime: DateTime.now,
          end_datetime: DateTime.now + 15.minutes,
          description: "elementary test event",
          user_id: 1)
        ).to be_valid
    end

    context "if nil title is set" do
      it "is not valid" do
        expect(
          Event.new(
            title: nil,
            begin_datetime: DateTime.now,
            end_datetime: DateTime.now + 15.minutes,
            description: "elementary test event",
            user_id: 1)
          ).not_to be_valid
      end
    end

    context "if nil begin_datetime is set" do
      it "is not valid" do
        expect(
          Event.new(
            title: "Test_event",
            begin_datetime: nil,
            end_datetime: DateTime.now + 15.minutes,
            description: "elementary test event",
            user_id: 1)
          ).not_to be_valid
      end
    end

    context "if nil end_datetime is set" do
      it "is not valid" do
        expect(
          Event.new(
            title: "Test_event",
            begin_datetime: DateTime.now,
            end_datetime: nil,
            description: "elementary test event",
            user_id: 1)
          ).not_to be_valid
      end
    end

    context "if nil user_id is set" do
      it "is not valid" do
        expect(
          Event.new(
            title: "Test_event",
            begin_datetime: DateTime.now,
            end_datetime: DateTime.now + 15.minutes,
            description: "elementary test event",
            user_id: nil)
          ).not_to be_valid
      end
    end

    context "if nil description is set" do
      it "is valid" do
        expect(
          Event.new(
            title: "Test_event",
            begin_datetime: DateTime.now,
            end_datetime: DateTime.now + 15.minutes,
            description: nil,
            user_id: 1)
          ).to be_valid
      end
    end

  end
end
