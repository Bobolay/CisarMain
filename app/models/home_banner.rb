class HomeBanner < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :article
  attr_accessible :article, :article_id

  image :image, styles: { slide: "1920x1080#", thumb: "192x108#" }


  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  globalize :label, :name, :short_description

  has_link

  def self.load_data_defaults(associations = {})
    defaults = 5.times.map do |i|
      item_defaults = {}

      I18n.available_locales.each do |locale|
        locale = locale.to_sym
        item_defaults[:translations] = {}
        item_defaults[:translations][locale] = {}
        item_defaults[:translations][locale][:name] = Fake.words(locale: locale)
        item_defaults[:translations][locale][:short_description] = Fake.sentence(locale: locale)
        item_defaults[:translations][locale][:label] = {uk: "спецпропозиція", en: "special offer"}[locale]
      end

      item_defaults[:published] = 't'

      item_defaults
    end
  end

  def self.load_data(associations = {})
    defaults = self.load_data_defaults(associations)
    LoadData.load_resources(self, associations, defaults)

    self.all.each do |item|
      [:name, :short_description].each do |column_name|
        I18n.available_locales.each do |locale|
          locale = locale.to_sym
          t = item.translations_by_locale[locale]
          if t
            t.send("#{column_name}=", Fake.words(locale: locale))
          end
        end
      end

      item.save
    end
  end

end
