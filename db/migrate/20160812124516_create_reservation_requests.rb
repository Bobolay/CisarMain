class CreateReservationRequests < ActiveRecord::Migration
  def change
    create_table :reservation_requests do |t|
      t.string :referer
      t.string :session_id
      t.string :name
      t.string :phone
      t.string :email
      t.belongs_to :room_node, polymorphic: true
      t.date :checkin_date
      t.date :checkout_date

      t.timestamps null: false
    end
  end
end
