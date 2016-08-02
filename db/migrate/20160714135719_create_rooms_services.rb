class CreateRoomsServices < ActiveRecord::Migration
  def change
    create_table :rooms_services do |t|
      t.belongs_to :room
      t.belongs_to :service
    end
  end
end
