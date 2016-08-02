class CreateServices < ActiveRecord::Migration
  def up
    create_table :services do |t|
      t.attachment :image
      t.attachment :icon
      t.string :name
      t.text :short_description
      t.boolean :published
      t.integer :sorting_position
      t.boolean :featured
      t.string :category


      t.timestamps null: false
    end

    Service.initialize_globalize
    Service.create_translation_table!(name: :string, short_description: :text)


  end

  def down
    Service.drop_translation_table!

    drop_table :services
  end
end
