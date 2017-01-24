class PageBanner < ActiveRecord::Base
  attr_accessible *attribute_names
  belongs_to :attachable, polymorphic: true
  image :image, styles: { xxl: "2000x600#", thumb: "200x60" }
  image :info_header_icon
  globalize(:title, :description, :info_header_text)

  has_cache do
    if self.attachable
      pages self.attachable
    end
  end
end
