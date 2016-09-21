module Pages
  class Excursions < Page
    def url(*args)
      url_from_routes(*args)
    end
  end
end