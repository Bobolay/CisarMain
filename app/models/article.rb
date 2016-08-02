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


  has_cache
  has_tags
  has_seo_tags

  before_save :initialize_released_on
  def initialize_released_on
    self.released_on = DateTime.now
  end

  def formatted_released_on(return_string = true, locale = I18n.locale)
    month_names = { uk: %w(січня лютого березня квітня травня червня липня серпня вересня жовтня листопада грудня),
      ru: %w(января февраля марта апреля мая июня июля августа сентября октября ноября декабря),
      en: %w(january february march april may june jule august september october november december)
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
end
