class OrdersController < ApplicationController
  def index
    @orders = Order.where(room_id: params[:room_id])
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @events = if current_user.role == "admin" then Event.all else current_user.events end
    @rooms = Room.all
    @room_id = params[:room_id]
    @event_id = params[:event_id]
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      unless @order.event.rooms.exists?(@order.room.id)
        @order.event.rooms << @order.room
      end
      redirect_to session.delete(:return_to)
    else
      redirect_to action: 'new', room_id: @order.room_id, event_id: @order.event_id
    end
  end

  def edit
    @order = Order.find(params[:id])
    @events = if current_user.role == "admin" then Event.all else current_user.events end
    @rooms = Room.all
  end

  def update
    @order = Order.find(params[:id])
    @events = if current_user.role == "admin" then Event.all else current_user.events end
    @rooms = Room.all

    if @order.update(order_params)
      redirect_to @order
    else
      render 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    room_id = @order.room_id
    event_id = @order.event_id

    @order.destroy

    if Order.where(room_id: room_id, event_id: event_id).empty?
      Room.find(room_id).events.destroy(event_id)
    end

    redirect_to session.delete(:return_to)
  end

  def order_params
    params.require(:order).permit(:room_id, :begin_datetime, :end_datetime, :event_id)
  end
end
