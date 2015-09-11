class AddUserIdToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :user_id, :integer
  end
end
