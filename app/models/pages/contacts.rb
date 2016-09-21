module Pages
  class Contacts < Page
    field :address
    field :phones
    field :emails

    def url(*args)
      url_from_routes(*args)
    end
  end
end