class RoomTag < ActiveRecord::Base
  attr_accessible *attribute_names
  globalize :name

  image :icon

  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }


  has_and_belongs_to_many :rooms

  has_cache do
    pages Room.published
    pages :rooms
  end
end
