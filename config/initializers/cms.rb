Cms.config do |config|
  #config.banner_class PageBanner
  config.provided_locales [:uk]
  config.use_translations true
end

Cms::CompressionConfig.initialize_compression