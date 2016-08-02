class Pages::Home < Cms::Page
  def self.full_screen_image_styles
    { thumb: '150x150' }
  end

  has_images :home_gallery_images, styles: {thumb: "100x100#", small: "450x250#", wide: "900x250#", medium: "700x500#", large: "2000x1000>"}

  def url(locale = I18n.locale)
    "/#{locale}"
  end

  has_html_block :hotel_intro
  has_images :home_hotel_images, styles: {thumb: "100x100#", image: "700x400#"}
  has_images :home_cafe_images, styles: {thumb: "100x100#", image: "1000x250#"}



end