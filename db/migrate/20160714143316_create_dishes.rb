class CreateDishes < ActiveRecord::Migration
  def up
    create_table :dishes do |t|
      t.string :label
      t.string :name
      t.text :short_description
      t.integer :price
      t.attachment :image
      t.boolean :published
      t.integer :sorting_position

      t.timestamps null: false
    end

    Dish.initialize_globalize
    Dish.create_translation_table!(label: :string, name: :string, short_description: :text)
  end

  def down
    Dish.drop_translation_table!

    drop_table :dishes
  end
end
