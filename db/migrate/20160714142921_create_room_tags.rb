class CreateRoomTags < ActiveRecord::Migration
  def up
    create_table :room_tags do |t|
      t.attachment :icon
      t.string :name
      t.boolean :published
      t.integer :sorting_position

      t.timestamps null: false
    end

    RoomTag.create_translation_table(:name)
  end

  def down
    RoomTag.drop_translation_table

    drop_table :room_tags
  end
end
