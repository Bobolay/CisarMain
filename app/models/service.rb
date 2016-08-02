class Service < ActiveRecord::Base
  attr_accessible *attribute_names

  include Enumerize
  enumerize :category, in: [:free, :paid], default: :free

  globalize :name, :short_description




  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }
  scope :featured, -> { where(featured: 't') }
  scope :free, -> { where(category: "free") }
  scope :paid, -> { where(category: "paid") }

  image :icon
  image :image, styles: { xxl: "650x433#", thumb: "130x86#" }

  has_and_belongs_to_many :rooms

  def self.load_data(associations = {})
    LoadData.load_resources(self, associations)

    self.all.each do |item|
      item.published = 't'

      item.save
    end
  end


end
