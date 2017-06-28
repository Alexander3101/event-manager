require 'rails_helper'

RSpec.describe Order, type: :model do
  let (:r_id) { Room.order(id: :desc).first[:id] }
  let (:e_id) { Event.order(id: :desc).first[:id] }
  let(:order) do
    Order.new(
      begin_datetime: DateTime.now,
      end_datetime: DateTime.now + 15.minutes,
      room_id: r_id,
      event_id: e_id
    )
  end

  describe ".new" do

    it "is valid with valid attributes" do
       expect(order).to be_valid
    end

    context "if nil begin_datetime is set" do
      it "is not valid" do
        order[:begin_datetime] = nil
        expect(order).not_to be_valid
      end
    end

    context "if nil end_datetime is set" do
      it "is not valid" do
        order[:end_datetime]=nil
        expect(order).not_to be_valid
      end
    end

    context "if end_datetime is earlier than begin_datetime" do
      it "is not valid" do
        order[:end_datetime] = order[:begin_datetime]-15.minutes
        expect(order).not_to be_valid
      end
    end

    context "if nil room_id is set" do
      it "is not valid" do
        order[:room_id] = nil
        expect(order).not_to be_valid
      end
    end

    context "if missed room_id is set" do
      it "is not valid" do
        order[:room_id] = r_id + 1
        expect(order).not_to be_valid
      end
    end

    context "if nil event_id is set" do
      it "is not valid" do
        order[:event_id] = nil
        expect(order).not_to be_valid
      end
    end

    context "if missed event_id is set" do
      it "is not valid" do
        order[:event_id] = e_id + 1
        expect(order).not_to be_valid
      end
    end
  end

end
