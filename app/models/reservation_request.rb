class ReservationRequest < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :room_version
  attr_accessible :room_version
end
