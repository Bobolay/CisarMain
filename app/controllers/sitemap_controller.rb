class SitemapController < ApplicationController
  caches_page :index
  def index
    @content = Pages.sitemap_xml.try(:content)
    if @content.blank?
      @entries = Cms::SitemapElement.entries(:uk)
    end

    render layout: false
  end
end