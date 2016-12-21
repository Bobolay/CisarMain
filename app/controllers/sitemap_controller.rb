class SitemapController < ApplicationController
  caches_page :index
  def index
    @content = Pages.sitemap_xml.try(:content)
    if @content.blank?
      @entries = Cms::SitemapElement.entries(Cms.config.provided_locales)
    end

    render layout: false
  end
end