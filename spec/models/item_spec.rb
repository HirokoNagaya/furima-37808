require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できるとき' do
      it 'image,item_name、description、category_id、
      condition_id、shipping_charge_id、sender_id、day_to_ship_id、priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できないとき' do
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end
      it 'descriptionが空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end
      it 'category_idが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not a number')
      end
      it 'condition_idが空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include 'Condition is not a number'
      end
      it 'shipping_charge_idが空では登録できない' do
        @item.shipping_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include 'Shipping charge is not a number'
      end
      it 'sender_idが空では登録できない' do
        @item.sender_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include 'Sender is not a number'
      end
      it 'day_to_ship_idが空では登録できない' do
        @item.day_to_ship_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include 'Day to ship is not a number'
      end
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it 'category_idが「---」の時は保存できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Category must be other than 1'
      end
      it 'condition_idが「---」の時は保存できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Condition must be other than 1'
      end
      it 'shipping_charge_idが「---」の時は保存できない' do
        @item.shipping_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Shipping charge must be other than 1'
      end
      it 'sender_idが「---」の時は保存できない' do
        @item.sender_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Sender must be other than 1'
      end
      it 'day_to_ship_idが「---」の時は保存できない' do
        @item.day_to_ship_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Day to ship must be other than 1'
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it '価格が299以下では登録できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than 299')
      end
      it '価格が9,999,999以上では登録できない' do
        @item.price = '9999999'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 9999999')
      end
      it '価格に半角数値以外の文字（平仮名・漢字・英字・記号）が含まれていると登録できない' do
        @item.price = 'すぎ元a@'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
