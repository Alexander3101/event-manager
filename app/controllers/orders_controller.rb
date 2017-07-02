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

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to @order
    else
      render 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to home_path
  end

  def order_params
    params.require(:order).permit(:room_id, :begin_datetime, :end_datetime, :event_id)
  end
end
