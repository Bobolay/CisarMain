class Page < Cms::Page
  has_one :banner, class_name: PageBanner, as: :attachable
  accepts_nested_attributes_for :banner
  attr_accessible :banner, :banner_id, :banner_attributes

end