require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:begin_t) { DateTime.new(2017, 10, 10, 9, 0, 0, "+03:00") }
  let(:end_t) { DateTime.new(2017, 10, 10, 19, 0, 0, "+03:00") }
  let(:room) do
    Room.new(
      title: "Test_room",
      begin_work_time: begin_t,
      end_work_time: end_t,
      description: "elementary test room")
  end

  describe ".new" do

    it "is valid with valid attributes" do
      expect(room).to be_valid
    end

    # TITLE tests
    context "TITLE tests" do
      it "is invalid if nil title is set" do
        room[:title] = nil
        expect(room).not_to be_valid
      end
    end

    # BEGIN_WORK_TIME tests
    context "BEGIN_WORK_TIME tests" do
      it "is invalid if nil begin_work_time is set" do
        room[:begin_work_time] = nil
        expect(room).not_to be_valid
      end

      it "is invalid if empty begin_work_time is set " do
        room[:begin_work_time] = ""
        expect(room).not_to be_valid
      end

      it "is invalid if wrong begin_datetime is set " do
        room[:begin_work_time] = "0o0o0"
        expect(room).not_to be_valid
      end
    end

    # END_WORK_TIME tests
    context "END_WORK_TIME tests" do
      it "is invalid if nil end_work_time is set" do
        room[:end_work_time] = nil
        expect(room).not_to be_valid
      end

      it "is invalid if empty begin_work_time is set " do
        room[:end_work_time] = ""
        expect(room).not_to be_valid
      end

      it "is invalid if wrong begin_datetime is set " do
        room[:end_work_time] = "0o0o0"
        expect(room).not_to be_valid
      end
    end

    # WORK_TIME tests
    context "WORK_TIME tests" do
      it "is invalid if end_wt is earlier than begin_wt (time)" do
        room[:end_work_time] = begin_t - 15.minutes
        expect(room).not_to be_valid
      end

      it "is invalid if end_work_time is earlier than begin_work_time (date)" do
        room[:end_work_time] = end_t - 1.day
        expect(room).not_to be_valid
      end

      it "is invalid if work time is longer than 1 day" do
        room[:end_work_time] = end_t + 2.days
        expect(room).not_to be_valid
      end
    end

    # DESCRIPTION tests
    context "DESCRIPTION tests" do
      it "is valid if nil description is set" do
        room[:description] = nil
        expect(room).to be_valid
      end
    end
  end

  describe ".delete" do
    it "removes dependent orders" do
      room = Room.first
      orders = Order.where("room_id = #{room[:id]}")
      room.destroy

      expect(Order.all).not_to include {orders}
    end
  end

end
