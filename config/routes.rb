Rails.application.routes.draw do
  root as: "root_without_locale", to: "application#root_without_locale"
  get "admin", to: redirect("/#{I18n.default_locale}/admin")



  scope ":locale", locale: /#{I18n.available_locales.map(&:to_s).join("|")}/ do
    devise_for :users
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  controller :pages do
    root action: "index"
    get "services", action: "services", as: :services
    get "cafe", action: "cafe", as: :cafe
    get "contacts", action: "contacts"
  end

  resources :events, only: [:index, :show]
  resources :excursions, only: [:index, :show]
  resources :fun_articles, only: [:index, :show]
  scope "blog", controller: "blog" do
    root action: "index", as: :blog
    get ":id", action: :show, as: :blog_article
  end

  scope "rooms", controller: "rooms" do
    root action: "index", as: :rooms
    get ":id", action: "show", as: :room
  end


  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Ckeditor::Engine => '/ckeditor'
  #devise_for :users
  end

  match "*url", to: "application#render_not_found", via: [:get, :post, :path, :put, :update, :delete]
end