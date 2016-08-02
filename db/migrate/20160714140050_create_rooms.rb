class CreateRooms < ActiveRecord::Migration
  def up
    create_table :rooms do |t|
      t.attachment :list_image
      t.attachment :banner_image

      t.string :name
      t.text :banner_description
      t.text :short_description
      t.string :url_fragment

      t.string :banner_title
      t.boolean :published
      t.integer :sorting_position

      t.text :description

      t.timestamps null: false
    end

    Room.initialize_globalize
    Room.create_translation_table!(name: :string, banner_description: :text, url_fragment: :string, short_description: :text, description: :text)
  end

  def down
    Room.drop_translation_table!

    drop_table :rooms
  end
end
