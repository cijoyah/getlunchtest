class AddImageToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :image, :text
  end
end
