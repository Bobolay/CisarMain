class Dish < ActiveRecord::Base
  attr_accessible *attribute_names
  globalize :label, :name, :short_description

  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }
  scope :featured, -> { where(featured: 't') }

  image :image, styles: { xxl: "650x433#", thumb: "130x86#" }

  has_and_belongs_to_many :rooms
end
