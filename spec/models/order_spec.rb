require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:u_id) do
    User.order(id: :desc).first[:id]
  end

  let(:event) do
    Event.order(id: :desc).first[:id]
  end
  let(:invalid_event_id) { event[:id] + 1 }

  let(:room) do
    Room.order(id: :desc).first[:id]
  end
  let(:invalid_room_id) { room[:id] + 1 }

  let(:order) do
    Order.new(
      begin_datetime: event.begin_datetime,
      end_datetime: event.end_datetime,
      room_id: room.id,
      event_id: event.id
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

    context "if order length is less than 15 minutes" do
      it "is not valid" do
        order[:end_datetime] = order[:begin_datetime] + 2.minutes
        expect(order).not_to be_valid
      end
    end

    context "if order length is less than event length" do
      it "is not valid" do
        order[:begin_datetime] = event[:begin_datetime]
        order[:end_datetime] = event[:end_datetime] - 1.minute
        expect(order).not_to be_valid
      end
    end

    # JUST STARTED
    context "if order time is beyond of the room work time" do
      it "is not valid" do
        b_date = DateTime.now
        b_date.hours = room.begin_work_time.hours

        order[:begin_datetime] = event[:begin_datetime]
        order[:end_datetime] = event[:end_datetime] - 1.minute
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
        order[:room_id] = invalid_room_id
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
        order[:event_id] = invalid_event_id
        expect(order).not_to be_valid
      end
    end
  end

end
