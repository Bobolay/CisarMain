#require 'globalize_extension'



RailsAdmin.config do |config|


  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show

    nestable do
      only [HomeBanner, Service, Room, Dish, InteriorComponent, RoomTag, SocialNetwork]
    end
  end

  config.include_models Cms::MetaTags, Cms::SitemapElement, Pages::SitemapXml

  config.include_models PageBanner

  config.include_models HomeBanner, User, Service, Room, RoomVersion, Dish, RoomTag, InteriorComponent

  config.include_models Pages::Home, Pages::Blog, Pages::Cafe, Pages::Contacts, Pages::Events, Pages::Excursions, Pages::FunArticles, Pages::NotFound, Pages::Rooms, Pages::Services

  config.include_models Attachable::Asset
  config.include_models Article, FunArticle, Excursion, Event, BlogArticle

  config.include_models Cms::Tag
  config.include_models SocialNetwork

  config.model Cms::MetaTags do
    visible false
    field :translations, :globalize_tabs
  end

  config.model_translation Cms::MetaTags do
    field :locale, :hidden
    field :title
    field :keywords
    field :description
  end

  config.model Pages::SitemapXml do
    field :content
  end

  config.model  Cms::SitemapElement do
    nested do
      field :display_on_sitemap
      field :changefreq
      field :priority
    end
  end

  config.include_models AdminSettings

  config.model AdminSettings do
    #field :default_priority, :float
    field :default_changefreq, :enum do
      enum do
        Cms::SitemapElement.changefreq.values.select {|k| k.to_sym != :default  }
      end
    end
  end

  config.model PageBanner do
    visible false
    field :image
    field :info_header_icon
    field :translations, :globalize_tabs
  end

  config.model_translation PageBanner do
    field :locale, :hidden
    field :title
    field :description
    field :info_header_text
  end

  config.model Cms::Tag do
    edit do
      field :translations, :globalize_tabs
    end
  end

  config.model_translation Cms::Tag do
    field :locale, :hidden
    field :name
    field :url_fragment
  end

  config.model Attachable::Asset do
    visible false
    nested do
      field :data
      field :translations, :globalize_tabs
    end
  end

  config.model_translation Attachable::Asset do
    field :locale, :hidden
    field :data_alt
  end

  config.model Pages::Contacts do
    field :banner
    field :seo_tags
    field :sitemap_record
  end

  config.model_translation Cms::Page do
    field :locale, :hidden
    field :content, :ck_editor
  end

  %w(blog cafe services rooms fun_articles events excursions terms_of_use site_map).each do |m|
    m = "Pages::#{m.camelize}"
    config.model m do
      field :banner
      field :seo_tags
      field :sitemap_record
    end
  end

  %w(not_found).each do |m|
    m = "Pages::#{m.classify}"
    config.model m do
      field :seo_tags
      field :sitemap_record
    end
  end

  config.model Pages::Home do
    edit do
      field :home_hotel_images
      field :home_cafe_images
      field :home_gallery_images
      field :seo_tags
      field :sitemap_record
    end
  end

  config.model User do
    field :email
    field :password
    field :password_confirmation
  end

  config.model HomeBanner do
    parent Pages::Home
    nestable_list({position_field: :sorting_position})

    field :published
    field :translations, :globalize_tabs
    field :image
    linkable_field([Article, Room, Cms::Page])
  end

  config.model_translation HomeBanner do
    field :locale, :hidden
    field :label
    field :name
    field :short_description
  end

  config.model Service do
    nestable_list({position_field: :sorting_position})

    field :category
    field :published
    field :featured
    field :image
    field :icon
    field :translations, :globalize_tabs
  end

  config.model_translation Service do
    field :locale, :hidden
    field :name
    field :short_description
  end

  config.model Room do
    nestable_list({position_field: :sorting_position})

    list do
      field :published
      field :list_image do
        label "avatar"
      end
      field :banner_image
      field :name
      field :price
    end

    edit do
      field :published
      field :list_image do
        label "avatar"
      end
      field :banner_image
      field :slider_images
      field :gallery_images
      field :price
      field :translations, :globalize_tabs
      field :room_versions
      field :dishes
      field :room_tags
      field :interior_components
      field :services
      field :seo_tags
      field :sitemap_record
    end
  end

  config.model_translation Room do
    field :locale, :hidden

    field :name
    field :url_fragment
    field :short_description
    field :banner_description
    field :description, :ck_editor

  end

  config.model RoomVersion do
    field :translations, :globalize_tabs
  end

  config.model_translation RoomVersion do
    field :locale, :hidden
    field :name
  end

  config.model Dish do
    nestable_list({position_field: :sorting_position})

    field :published
    field :featured
    field :image
    field :price
    field :translations, :globalize_tabs
    field :rooms

  end

  config.model_translation Dish do
    field :locale, :hidden
    field :label
    field :name
    field :short_description

  end

  config.model InteriorComponent do
    nestable_list({position_field: :sorting_position})

    field :published
    field :translations, :globalize_tabs
    field :rooms
  end

  config.model_translation InteriorComponent do
    field :locale, :hidden
    field :name
  end

  config.model RoomTag do
    nestable_list({position_field: :sorting_position})

    field :published
    field :icon
    field :translations, :globalize_tabs
    field :rooms
  end

  config.model_translation RoomTag do
    field :locale, :hidden
    field :name
  end

  def related_articles_field()
    field :related_articles do
      # help do
      #   bindings[:object].inspect
      # end
      associated_collection_scope do
        obj = bindings[:object]
        obj_id = obj.id
        rel = obj.class.all
        proc do
          if obj_id.blank?
            rel
          else
            rel.where.not(id: obj_id)
          end
        end
      end
    end
  end

  [BlogArticle, FunArticle, Event, Excursion].each do |m|
    config.model m do
      edit do
        field :published
        field :featured
        field :translations, :globalize_tabs
        field :avatar
        field :banner_image
        field :released_on
        field :tags
        related_articles_field
        field :seo_tags
        field :sitemap_record
      end
    end
  end





  config.model_translation Article do
    edit do
      field :locale, :hidden
      field :name
      field :url_fragment
      field :short_description
      field :content, :ck_editor
      field :banner_description
      field :banner_title
    end
  end

  config.model Article do
    edit do
      field :type, :enum do
        enum_method :get_available_types
      end
      field :published
      field :featured
      field :translations, :globalize_tabs
      field :avatar
      field :banner_image
      field :released_on
      field :tags
      related_articles_field
      field :seo_tags
      field :sitemap_record
    end
  end

  config.model SocialNetwork do
    nestable_list({position_field: :sorting_position})

    field :published
    field :key
    field :icon
    field :profile_url
    field :translations, :globalize_tabs
  end

  config.model_translation SocialNetwork do
    field :locale, :hidden
    fields :profile_tooltip, :share_tooltip
  end



  # [BlogArticle].each do |m|
  #
  # end

  config.include_models ContactInfo

  config.model ContactInfo do
    fields :lat_lg
    fields :emails, :phones do
      def value
        bindings[:object][name]
      end
    end
    field :translations, :globalize_tabs
  end

  config.model_translation ContactInfo do
    field :locale, :hidden
    field :address
  end

  config.include_models ReservationRequest, FormConfigs::ReservationRequest
  config.model ReservationRequest do
    group :common do
      field :name
      field :phone
      field :email
      field :room_node
      field :checkin_date
      field :checkout_date
    end
    group :technical do
      field :referer
      field :session_id
    end
  end

  config.model FormConfigs::ReservationRequest do
    navigation_label "Налаштування"
    field :email_receivers, :text
  end
end
