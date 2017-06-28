require 'rails_helper'

RSpec.describe Room, type: :model do

  let(:room) do
    Room.new(
      title: "Test_room",
      begin_work_time: Time.now,
      end_work_time: Time.now + 12.hours,
      description: "elementary test room")
  end

  describe ".new" do

    it "is valid with valid attributes" do
       expect(room).to be_valid
    end

    context "if nil title is set" do
      it "is not valid" do
        room[:title] = nil
        expect(room).not_to be_valid
      end
    end

    context "if nil begin_work_time is set" do
      it "is not valid" do
        room[:begin_work_time] = nil
        expect(room).not_to be_valid
      end
    end

    context "if nil end_work_time is set" do
      it "is not valid" do
        room[:end_work_time] = nil
        expect(room).not_to be_valid
      end
    end

    context "id if end_work_time is earlier than begin_work_time (time)" do
      it "is not valid" do
        room[:end_work_time] = event[:begin_work_time] - 15.minutes
        expect(room).not_to be_valid
      end
    end

    context "id if end_work_time is earlier than begin_work_time (date)" do
      it "is not valid" do
        room[:end_work_time] = event[:end_work_time] - 1.day
        expect(room).not_to be_valid
      end
    end

    context "if work time is longer than 1 day" do
      it "is not valid" do
        room[:end_work_time] = event[:begin_work_time] + 2.days
        expect(room).not_to be_valid
      end
    end

    context "if nil description is set" do
      it "is valid" do
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
