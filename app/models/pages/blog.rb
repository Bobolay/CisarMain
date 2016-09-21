module Pages
  class Blog < Page
    def url(*args)
      url_from_routes(*args)
    end
  end
end