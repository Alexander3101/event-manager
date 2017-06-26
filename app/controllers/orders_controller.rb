class OrdersController < ApplicationController
  def new
    @order = Order.new
    @events = Event.all
    @room_id = params[:room_id]
  end

  def create
    @order = Order.new(order_params)
    @order.event.rooms << @order.room
    
    if @order.save
      redirect_to room_path(@order.room_id)
    else
      redirect_to '/rooms'
    end
  end

  def order_params
    params.require(:order).permit(:room_id, :begin_datetime, :end_datetime, :event_id)
  end
end
