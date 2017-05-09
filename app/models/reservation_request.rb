class ReservationRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :room_node, polymorphic: true
  attr_accessible :room_node

  validates :email, :phone, presence: true

  def room_node=(key)
    parts = key.split("-")
    class_name = parts[0].camelize
    id = parts[1].to_i
    self.room_node_id = id
    self.room_node_type = class_name
  end

  def notify_admin
    ApplicationMailer.reservation_request(self).deliver_now
  end

  def self.notify_admin_about_all
    self.all.map(&:notify_admin)
  end
end
