Rails.application.routes.draw do
  root to: "pages#index"

  controller :pages do
    get "about-us", action: "about_us"
    get "rooms", action: "rooms"
    get "room_one", action: "room_one"
    get "services", action: "services"
    get "cafe", action: "cafe"
    get "info", action: "info"
    get "publications", action: "publications"
    get "publication_one", action: "publication_one"
    get "contacts", action: "contacts"
    get "not_found", action: "not_found"
  end

  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # mount Ckeditor::Engine => '/ckeditor'
  #devise_for :users


  match "*url", to: "application#render_not_found", via: [:get, :post, :path, :put, :update, :delete]
end