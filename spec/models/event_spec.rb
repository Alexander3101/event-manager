require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:u_id) do
    User.order(id: :desc).first[:id]
  end

  describe ".new" do
    
    it "is valid with valid attributes" do
       expect(
        Event.new(
          title: "Test_event",
          begin_datetime: DateTime.now,
          end_datetime: DateTime.now + 15.minutes,
          description: "elementary test event",
          user_id: u_id)
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
            user_id: u_id)
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
            user_id: u_id)
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
            user_id: u_id)
          ).not_to be_valid
      end
    end

    context "if end_datetime is earlier than begin_datetime" do
      it "is not valid" do
        expect(
         Event.new(
           title: "Test_event",
           begin_datetime: DateTime.now,
           end_datetime: DateTime.now - 15.minutes,
           description: "elementary test event",
           user_id: u_id)
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

    context "if missed user_id is set" do
      it "is not valid" do
        expect(
          Event.new(
            title: "Test_event",
            begin_datetime: DateTime.now,
            end_datetime: DateTime.now + 15.minutes,
            description: "elementary test event",
            user_id: u_id + 1)
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
            user_id: u_id)
          ).to be_valid
      end
    end
  end

  describe ".delete" do
    it "removes dependent orders" do
      event = Event.first
      orders = Order.where("event_id = #{event[:id]}")
      event.destroy

      expect(Order.all).not_to include {orders}
    end
  end

end
