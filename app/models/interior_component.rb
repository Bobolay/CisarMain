class InteriorComponent < ActiveRecord::Base
  attr_accessible *attribute_names
  globalize :name

  def self.load_data
    LoadData.load_resources(self)

    self.all.each do |item|
      item.published = 't'

      item.save
    end
  end

  has_and_belongs_to_many :rooms
  has_cache do
    pages Room.published
  end
end
