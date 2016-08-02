class InfoArticlesController < ArticlesController
  def category
    self.resource_class
  end
  def categories
    [Event, Excursion, FunArticle]
  end

  helper_method :category, :categories
end