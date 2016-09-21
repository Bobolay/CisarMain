module Pages
  class Rooms < Page
    def url(*args)
      url_from_routes(*args)
    end
  end
end