class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @order_addresses = OrderAddress.all
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @dorder_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postcode, :sender_id, :city, :street, :building, :phone_number, :order, :item).merge(user_id: current_user.id)
  end
end
