class CreateRoomVersions < ActiveRecord::Migration
  def up
    create_table :room_versions do |t|
      t.belongs_to :room
      t.string :name

      t.timestamps null: false
    end

    RoomVersion.create_translation_table(:name)
  end

  def down
    RoomVersion.drop_translation_table

    drop_table :room_versions
  end
end
