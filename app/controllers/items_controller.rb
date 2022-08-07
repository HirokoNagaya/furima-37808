class ItemsController < ApplicationController
  def index
  end

  private

  def  item_params
    params.require(:item).permit(:item_name, :image, :description, :category_id, :condition_id, :shipping_charge_id, :sender_id, :day_to_ship_id, :price).merge(user_id: current_user.id)
  end
end
