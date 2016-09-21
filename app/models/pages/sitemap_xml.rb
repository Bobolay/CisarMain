module Pages
  class SitemapXml < Cms::Page
    attr_accessible *attribute_names

    def self.disabled?
      true
    end
  end
end