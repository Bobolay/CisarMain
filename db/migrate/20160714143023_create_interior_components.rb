class CreateInteriorComponents < ActiveRecord::Migration
  def up
    create_table :interior_components do |t|
      t.string :name
      t.boolean :published
      t.integer :sorting_position

      t.timestamps null: false
    end

    InteriorComponent.initialize_globalize
    InteriorComponent.create_translation_table!(name: :string)
  end

  def down
    InteriorComponent.drop_translation_table!

    drop_table :interior_components
  end
end
