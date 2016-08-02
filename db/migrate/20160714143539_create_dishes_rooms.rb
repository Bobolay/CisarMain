class CreateDishesRooms < ActiveRecord::Migration
  def change
    create_join_table :dishes, :rooms
  end
end
