class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    item_definition
  end

  def edit
    item_definition
  end

  def update
    item_definition
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_definition
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:item_name, :image, :description, :category_id, :condition_id, :shipping_charge_id, :sender_id,
                                 :day_to_ship_id, :price).merge(user_id: current_user.id)
  end

  def contributor_confirmation
    item_definition
    redirect_to root_path unless current_user == @item.user
  end
end
