require 'rails_helper'

RSpec.describe Event, type: :model do
  # it takes the biggest id, so (u_id+1) doesn't exist
  let(:u_id) do
    User.order(id: :desc).first[:id]
  end
  let(:event) do
    Event.new(
      title: "Test_event",
      begin_datetime: DateTime.now,
      end_datetime: DateTime.now + 15.minutes,
      description: "elementary test event",
      user_id: u_id)
  end

  describe ".new" do

    it "is valid with valid attributes" do
       expect(event).to be_valid
    end

    # TITLE tsts
    context "TITLE tests" do
    it "isn't valid if nil title is set" do
      event[:title] = nil
      expect(event).not_to be_valid
    end
  end

    # BEGIN_DATEIME tests
    context "BEGIN_DATEIME tests" do
      it "isn't valid if nil begin_datetime is set" do
        event[:begin_datetime] = nil
        expect(event).not_to be_valid
      end

      it "isn't valid if empty begin_datetime is set " do
        event[:begin_datetime] = ""
        expect(event).not_to be_valid
      end

      it "isn't valid if wrong begin_datetime is set " do
        event[:begin_datetime] = "0o0o0"
        expect(event).not_to be_valid
      end
    end

    # END_DATEIME tests
    context "END_DATEIME tests" do
      it "isn't valid if nil end_datetime is set" do
        event[:end_datetime] = nil
        expect(event).not_to be_valid
      end

      it "isn't valid if empty end_datetime is set" do
        event[:end_datetime] = ""
        expect(event).not_to be_valid
      end

      it "isn't valid if wrong end_datetime is set " do
        event[:end_datetime] = "0o0o0"
        expect(event).not_to be_valid
      end
    end

    #DATETIME tests
    context "DATETIME tests" do
      it "isn't valid if end_datetime is earlier than begin_datetime" do
        event[:end_datetime] = event[:begin_datetime] - 15.minutes
        expect(event).not_to be_valid
      end

      it "isn't valid if event length is less than 15 minutes" do
        event[:end_datetime] = event[:begin_datetime] + 2.minutes
        expect(event).not_to be_valid
      end
    end

    # USER tests
    context "USER tests" do
      it "is not validif nil user_id is set" do
        event[:user_id] = nil
        expect(event).not_to be_valid
      end

      it "is not valid if missed user_id is set" do
        event[:user_id] = u_id + 1
        expect(event).not_to be_valid
      end

      it "is not valid if nil description is set" do
        event[:description] = nil
        expect(event).to be_valid
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
