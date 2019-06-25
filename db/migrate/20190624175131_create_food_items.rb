class CreateFoodItems < ActiveRecord::Migration[5.2]
  def change
    create_table :food_items do |t|
      t.belongs_to :category, index: true
      t.string :name
      t.text :modifiers
      t.string :availability
      t.decimal :price

      t.timestamps
    end
  end
end
