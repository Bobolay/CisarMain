class PagesController < ApplicationController
  before_action :set_page_instance, except: [:index]
  before_action :set_page_banner, except: [:index]

  def index
    @home_banners = HomeBanner.published.sort_by_sorting_position
    set_page_metadata(:home)
    ["home_hotel_images", "home_cafe_images"].each do |k|
      v = @page_instance.try(k.to_sym)
      if v
        v = v.map{|image| url = image.url; {image_url: url, name: image.data_alt} }
        instance_variable_set("@#{k}", v)
      end
    end
    @home_gallery_images = @page_instance.try(:home_gallery_images).map.with_index do|image, index|
      if index == 0
        image_key = :wide
      elsif index == 1 || (index >= 2 && index <= 4)
        image_key = :small
      else
        image_key = :medium
      end
      url = image.url(image_key);
      {thumb_url: url, large_url: url}
    end

    @featured_articles = Article.published.featured.order("released_on desc").limit(3)
    @featured_dishes = Dish.published.featured.order("id desc").limit(3)
  end

  def services
    @free_services = Service.published.free.sort_by_sorting_position
    @paid_services = Service.published.paid.sort_by_sorting_position
    @services_count = Service.published.count
  end

  def cafe
    @dishes = Dish.published.order("id desc")
    #Cms::Page.first
  end

  def contacts

  end

  def terms_of_use

  end

  def site_map

  end

  private

  def set_page_instance
    set_page_metadata(action_name)
  end


end