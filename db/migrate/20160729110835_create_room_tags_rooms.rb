class CreateRoomTagsRooms < ActiveRecord::Migration
  def change
    create_join_table :room_tags, :rooms
  end
end
