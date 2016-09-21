class Page < Cms::Page
  has_one :banner, class_name: PageBanner, as: :attachable
  accepts_nested_attributes_for :banner
  attr_accessible :banner, :banner_id, :banner_attributes

  def url_from_routes(locale = I18n.locale)
    Rails.application.routes.url_helpers.send("#{self.class.name.split("::").last.underscore}_#{locale}_path")
  end

end