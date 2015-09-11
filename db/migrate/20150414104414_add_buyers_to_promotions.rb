class AddBuyersToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :buyers, :int, default: 0
  end
end
