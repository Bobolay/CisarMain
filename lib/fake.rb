module Fake
  def self.word(options = {})
    words(1, options)
  end

  def self.words(count = 3, options = {})
    if count.is_a?(Hash)
      options = count
      count = 3
    end

    l_words = sentences(10, options).join(" ").split(/[\s\,\.\?\!\"\:\-]/).uniq
    count.times.map { l_words.sample }.join(" ")

  end

  def self.sentence(options = {})
    sentences(1, options).first
  end

  def self.sentences(count = 3, options = {})
    if count.is_a?(Hash)
      options = count
      count = 3
    end
    options.symbolize_keys!
    locale = options.delete(:locale)
    if !I18n.available_locales.map(&:to_s).include?(locale.to_s)
      locale = I18n.locale
    end

    category = options.delete(:category) || :design

    texts_data = YAML.load(File.open(Rails.root.join("config/locales/fake/#{category}.#{locale}.yml").to_s))
    all_sentences = texts_data[locale.to_s]["fake"][category.to_s]
    count.times.map do |i|
      all_sentences.sample + "."
    end


  end

  def paragraph(options = {})
    paragraphs(1, options)
  end

  def self.paragraphs(count = 3, options = {})
    if count.is_a?(Hash)
      options = count
      count = 3
    end

    count.times.map do |i|
      sentences(options).join(" ")
    end
  end

  def self.html(paragraphs_count = 3, options = {})
    if paragraphs_count.is_a?(Hash)
      options = paragraphs_count
      paragraphs_count = 3
    end
    paragraphs(paragraphs_count, options).map{|p| "<p>#{p}</p>" }.join("")
  end
end