class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.integer :business_id
      t.text :pitch
      t.text :description
      t.float :price
      t.datetime :available_on_date
      t.datetime :start_time
      t.datetime :end_time
      t.string :cuisine
      t.integer :hotness

      t.timestamps null: false
    end
  end
end
