class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :item_definition, only: [:create, :index]
  before_action :move_to_index, :create
  before_action :redirection, :create
 

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
      if @order_address.valid?
        pay_item
        @order_address.save
        redirect_to root_path
      else
        render :index
      end
  end

  private

  def item_definition
    @item = Item.find(params[:item_id])
  end

  def redirection
    if @item.order.present? || current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
  end

  def order_params
    params.require(:order_address).permit(:postcode, :sender_id, :city, :street, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key =  ENV["PAYJP_SECRET_KEY"]  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )      
  end

end
