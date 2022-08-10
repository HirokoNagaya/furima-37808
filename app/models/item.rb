class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :sender
  belongs_to :day_to_ship
  

  belongs_to :user

  has_one_attached :image

  #メモ；空の投稿を保存できないようにする
  validates :item_name, presence: true
  validates :description, presence: true
  validates :price, numericality: {greater_than: 300,less_than: 9999999}, presence: true


  #メモ；ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, numericality: { other_than: 1 }
  validates :condition_id, numericality: { other_than: 1 }
  validates :shipping_charge_id, numericality: { other_than: 1 }
  validates :sender_id, numericality: { other_than: 1 }
  validates :day_to_ship_id, numericality: { other_than: 1 }     
end
