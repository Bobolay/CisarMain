class Room < ActiveRecord::Base
  attr_accessible *attribute_names
  globalize :name, :banner_description, :url_fragment, :short_description, :description
  has_many :room_versions
  accepts_nested_attributes_for :room_versions
  attr_accessible :room_versions, :room_version_ids, :room_versions_attributes

  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  image :banner_image, styles: {xxl: "2000x600#", thumb: "200x60#"}
  image :list_image, styles: { xxl: "650x433#", thumb: "130x86#", avatar: "150x150#" }
  has_images :slider_images, styles: {xxl: "1000x1000#", thumb: "100x100#"}
  has_images :gallery_images, styles: { thumb: "100x100#", site_thumb: "200x200#", large: "2000x1000>" }




  has_and_belongs_to_many :dishes
  has_and_belongs_to_many :interior_components
  has_and_belongs_to_many :services
  has_and_belongs_to_many :room_tags

  attr_accessible :dish_ids, :room_tag_ids, :service_ids, :interior_component_ids

  has_cache do
    pages :blog, :cafe, :contacts, :events, :excursions, :fun_articles, :home, :not_found, :rooms, :services, :site_map, :sitemap_xml, :terms_of_use
    pages self, Room.published, Article.published
  end
  has_seo_tags
  has_sitemap_record

  def linkable_path
    name = self.name
    name = "##{self.id}"
    #category_key = self.class.name.underscore
    category_name = "Номери"

    "#{category_name} -> #{name}"
  end


  def full_name
    name
  end

end
