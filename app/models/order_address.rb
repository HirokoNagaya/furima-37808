class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postcode, :sender_id, :city, :street, :building, :phone_number, :order_id, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :sender_id, numericality: { other_than: 1 }
    validates :city
    validates :street
    validates :phone_number, length: { in: 9..12 }, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Exclude hyphen(-)' }
    validates :token
  end

  def save
    # 購入情報を保存し、変数order代入する
    order = Order.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    Address.create(postcode: postcode, sender_id: sender_id, city: city, street: street, phone_number: phone_number,
                   order_id: order.id)
  end
end
