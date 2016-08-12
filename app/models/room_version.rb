class RoomVersion < ActiveRecord::Base
  attr_accessible *attribute_names
  globalize :name
  belongs_to :room
  attr_accessible :room
end
