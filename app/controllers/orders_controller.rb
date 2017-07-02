class OrdersController < ApplicationController
  def index
    @orders = Order.where(room_id: params[:room_id])
  end
  def show
    @order = Order.find(params[:id])
  end
  def new
    @order = Order.new
    @events = Event.all
    @rooms = Room.all
    @room_id = params[:room_id]
    @event_id = params[:event_id]
  end

  def create
    @order = Order.new(order_params)
    @order.event.rooms << @order.room

    if @order.save
      redirect_to session.delete(:return_to)
    else
      render 'new'
    end
  end

  def order_params
    params.require(:order).permit(:room_id, :begin_datetime, :end_datetime, :event_id)
  end
end
