class RoomVersion < ActiveRecord::Base
  attr_accessible *attribute_names
  globalize :name
  belongs_to :room
  attr_accessible :room

  def full_name
    if self.room
      "#{self.room.name} -> #{name}"
    else
      name
    end

  end
end
