class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  include ActionView::Helpers::OutputSafetyHelper
  include Cms::Helpers::ImageHelper
  include ActionView::Helpers::AssetUrlHelper
  include Cms::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include Cms::Helpers::PagesHelper
  include Cms::Helpers::MetaDataHelper
  include Cms::Helpers::NavigationHelper
  include Cms::Helpers::ActionView::UrlHelper

  before_action :set_locale, unless: :admin_panel?
  before_action :set_admin_locale, if: :admin_panel?
  before_action :initialize_rooms, unless: :admin_panel?
  before_action :initialize_social_networks, unless: :admin_panel?
  before_action :initialize_map, unless: :admin_panel?

  def set_admin_locale
    I18n.locale = :uk
  end

  def set_locale
    I18n.locale = params[:locale]
  end

  def admin_panel?
    admin = params[:controller].to_s.starts_with?("rails_admin")

    return admin
  end

  def render_not_found
    @render_header = false
    @render_footer = false

    set_page_metadata("not_found")

    render template: "errors/not_found.html.slim", layout: "application"
  end

  def default_url_options
    if admin_panel?
      {}
    else
      {locale: I18n.locale}
    end
  end

  def root_without_locale
    redirect_to root_path(locale: I18n.locale)
  end

  def initialize_rooms
    @rooms = with_translation(Room.published.sort_by_sorting_position)
  end

  def add_breadcrumb(name, url = nil)
    @_breadcrumbs ||= []
    obj = name
    if obj.is_a?(ActiveRecord::Base)
      name = obj.try(:name)
      url ||= obj.try(:url)
    end
    b = { }
    name = name.to_s
    b[:name] = (I18n.t("breadcrumbs.#{name}", raise: true) rescue name.humanize)

    url ||= send("#{name}_path")
    b[:url] = url
    @_breadcrumbs << b
  end

  def initialize_page_banner
    @banner = @page_instance
  end

  def initialize_social_networks
    @social_networks = SocialNetwork.published.sort_by_sorting_position
  end

  def initialize_map
    @contact_info = ContactInfo.first
  end

  def weather_and_exchange_rates
    rate = Cms::ExchangeRate.actual(:private_bank)
    rate.save if !rate.persisted?
    rates = rate.result

    weather_data = Cms::WeatherData.actual(ENV["openweathermap_app_id"])
    weather_data.save if !weather_data.persisted?
    weather_data = weather_data.result

    weather = weather_data['weather']
    puts "weather: #{weather.inspect}"

    json_response = { usd: rate.convert(1, :usd, :uah, :buy), eur: rate.convert(1, :eur, :uah, :buy), weather_data:
        (weather ? {
            id: weather[0]["id"],
            temperature: weather_data["main"]["temp"],
            icon: weather[0]['icon'],
            description: weather[0]['description']
        } : nil)
        #weather_data
    }

    @usd = json_response[:usd]
    @eur = json_response[:eur]
    @temperature = json_response[:weather_data] ? json_response[:weather_data][:temperature] : nil
    @weather_id = json_response[:weather_data] ? json_response[:weather_data][:id] : nil
    #@weather_icon = "icons/weather/#{@weather_id}.svg"

    @weather_png_icon_relative_path = json_response[:weather_data] ? "icons/weather_png2/#{json_response[:weather_data][:icon]}.png" : nil
    #@weather_png_icon = image_path(@weather_png_icon_relative_path)
    #@weather_png_icon = "http://openweathermap.org/img/w/#{json_response[:weather_data][:icon]}.png"
    @weather_description = json_response[:weather_data] ? json_response[:weather_data][:description] : nil

    render template: "application/_weather_and_exchange_rates.html.slim", layout: false

    #render json: json_response, status: 200
  end

  protected
  def set_page_banner
    ar_banner = @page_instance.try(:banner)
    if ar_banner
      banner = { image_url: ar_banner.image.url(:xxl), info_header_icon: ar_banner.info_header_icon.path, info_header_text: ar_banner.info_header_text, header: ar_banner.title, description: ar_banner.description }
    else
      banner = {}
    end
    @banner = banner
  end

  def with_translation(rel)
    translations_table_name = rel.model.translation_class.table_name
    rel
        .joins(:translations)
        .where("(#{translations_table_name}.url_fragment is not null and #{translations_table_name}.url_fragment<>'') and #{translations_table_name}.locale='#{I18n.locale}'")
  end


end
