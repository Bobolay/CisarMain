class BlogController < ArticlesController
  before_action :initialize_tags, only: [:index]

  def resource_class
    BlogArticle
  end

  def initialize_tags
    #@tags = Cms::Tag.all
    #@tags = BlogArticle.published
    @tags = Cms::Tag.joins(:taggings).where(cms_taggings: {taggable_id: BlogArticle.published.pluck(:id)}).uniq
  end
end