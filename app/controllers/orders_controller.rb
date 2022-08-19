class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  

  def create
   
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postcode, :sender_id, :city, :street, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
