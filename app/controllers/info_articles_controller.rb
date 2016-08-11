class InfoArticlesController < ArticlesController
  def index
    set_page_metadata(:events)
    set_page_banner
  end

  def category
    self.resource_class
  end
  def categories
    [Event, Excursion, FunArticle]
  end

  helper_method :category, :categories
end