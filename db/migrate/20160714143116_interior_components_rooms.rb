class InteriorComponentsRooms < ActiveRecord::Migration
  def change
    create_join_table :interior_components, :rooms
  end
end
