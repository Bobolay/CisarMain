class Article < ActiveRecord::Base
  attr_accessible *attribute_names
  globalize :name, :url_fragment, :short_description, :content, :banner_description, :banner_title
  has_and_belongs_to_many :related_articles,
                          class_name: "Article",
                          join_table: :article_relations,
                          foreign_key: :article_id,
                          association_foreign_key: :related_article_id

  attr_accessible :related_articles, :related_article_ids

  scope :published, -> { where(published: 't') }
  scope :featured, -> { where(featured: 't') }

  acts_as_article(tags: false, initialize_all_attachments: false, author: false)

  image :avatar, styles: { xxl: "650x433#",  thumb: "130x86#", list: "600x150#", avatar: "150x150#"}
  image :banner_image, styles: {xxl: "2000x600#", thumb: "200x60"}


  has_cache do
    pages :home, :events, :excursions, :fun_articles, :blog
    pages self, Article.all
  end

  has_tags
  has_seo_tags
  has_sitemap_record

  before_save :initialize_released_on
  def initialize_released_on
    self.released_on = DateTime.now
  end

  def url(locale = I18n.locale)
    url_fragment = translations_by_locale[locale].try(:url_fragment)
    route_name = self.class.name.underscore.singularize
    if url_fragment.blank?
      return nil
    end
    url_helpers.send("#{route_name}_#{locale}_path", locale: locale, id: url_fragment)
  end

  def formatted_released_on(return_string = true, locale = I18n.locale)
    month_names = { uk: %w(січня лютого березня квітня травня червня липня серпня вересня жовтня листопада грудня),
      ru: %w(января февраля марта апреля мая июня июля августа сентября октября ноября декабря),
      en: %w(january february march april may june jule august september october november december),
      pl: %w(styczego lutego mar kwietnia maj czerw lip sierp wrzes pazdzier listopad grud)

    }
    date_time = self.released_on

    month_number = date_time.month
    month_name = month_names[locale.to_sym][month_number - 1]
    day = date_time.day
    year = date_time.year
    if return_string
      "#{day} #{month_name} #{year}"
    else
      {day: day, month_name: month_name, year: year}
    end
  end

  def linkable_path
    name = self.name
    name = "##{self.id}"
    category_key = self.class.name.underscore
    category_name = I18n.t("article_categories.#{category_key}", raise: true) rescue "test"

    "#{category_name} -> #{name}"
  end

  before_save do
    types = get_available_types(true)
    self_type = self['type']
    if self_type.blank? || !types.include?(self_type)
      self['type'] = types.first
    end
  end

  def get_available_types(value_only = false)
    classes = Article.descendants
    if value_only
      return classes.map(&:name)
    end

    classes.map{|m| model_key = m.name.underscore; model_label = (I18n.t("activerecord.models.#{model_key}.one", raise: true) rescue nil)  || (I18n.t("activerecord.models.#{model_key}", raise: true) rescue m.name);  [model_label, m.name]  }
  end
end
