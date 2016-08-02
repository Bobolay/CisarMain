class ArticlesController < ApplicationController
  before_action :initialize_articles, only: [:index]
  before_action :initialize_article, only: [:show]
  before_action :initialize_breadcrumbs, only: [:show]

  def index
    set_page_metadata(index_page_key)
  end

  def show
    if @article
      initialize_articles
      set_page_metadata(@article)
    end
  end

  protected
  def resource_class
    @resource_class ||= self.class.name.split("::").last.gsub(/Controller\Z/, "").singularize.constantize
  end

  def index_page_key
    params[:controller]
  end

  def initialize_article
    @article = resource_class.published.joins(:translations).where(article_translations: { url_fragment: params[:id], locale: params[:locale] } ).first
    if @article.nil?
      render_not_found
    else
      banner_title = @article.banner_title
      banner_title = @article.name if banner_title.blank?
      date_time = @article.formatted_released_on(false)
      @banner = {image_url: @article.banner_image.url(:xxl),
                 description: @article.short_description,
                 title: banner_title,
                 info_header: { icon: "icons/calendar.svg", text: "#{date_time[:day]} <span>#{date_time[:month_name]} #{date_time[:year]}</span>" }}
    end
  end

  def initialize_breadcrumbs
    add_breadcrumb(:home, root_path)
    add_breadcrumb(index_page_key)
    add_breadcrumb(@article)
  end

  def initialize_articles
    @articles = resource_class.published
  end
end