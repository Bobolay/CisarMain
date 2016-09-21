Rails.application.routes.draw do
  get "sitemap", to: "sitemap#index", format: "xml", as: :sitemap_xml
  get "weather_and_exchange_rates", to: "application#weather_and_exchange_rates"
  root as: "root_without_locale", to: "application#root_without_locale"
  get "admin", to: redirect("/#{I18n.default_locale}/admin")

  post "reservation_request", to: "rooms#reservation_request", as: :reservation_request



  #scope ":locale", locale: /#{I18n.available_locales.map(&:to_s).join("|")}/ do
  localized do
    devise_for :users
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

    controller :pages do
      root action: "index"

      get "services", action: "services", as: :services
      get "cafe", action: "cafe", as: :cafe
      get "contacts", action: "contacts"
      get "sitemap", action: "site_map"
      get "terms-of-use", action: "terms_of_use"
    end

    scope "info" do
      resources :events, only: [:index, :show]
      resources :excursions, only: [:index, :show]
      resources :fun_articles, only: [:index, :show]
      scope "blog", controller: "blog" do
        root action: "index", as: :blog
        get ":id", action: :show, as: :blog_article
      end
    end


    get "rooms_index", to: "rooms#index", as: "rooms"
    scope "rooms", controller: "rooms" do
      get ":id", action: "show", as: :room
    end


    # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    # mount Ckeditor::Engine => '/ckeditor'
    #devise_for :users
  end
  match "*url", to: "application#render_not_found", via: [:get, :post, :path, :put, :update, :delete]
end