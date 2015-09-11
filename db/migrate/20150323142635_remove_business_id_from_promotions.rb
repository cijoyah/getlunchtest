class RemoveBusinessIdFromPromotions < ActiveRecord::Migration
  def change
    remove_column :promotions, :business_id
  end
end
