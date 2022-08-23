class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]
  before_action :item_definition, only: [:create, :index]
  before_action :redirection_soldout, only: [:create, :index]
  before_action :redirection_user, only: [:create, :index]

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

  def redirection_user
    redirect_to root_path if current_user.id == @item.user_id
  end

  def redirection_soldout
    redirect_to root_path if @item.order.present?
  end

  def order_params
    params.require(:order_address).permit(:postcode, :sender_id, :city, :street, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
