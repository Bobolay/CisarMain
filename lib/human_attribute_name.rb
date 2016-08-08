module NameHelper
  def human_attribute_name(attr)
    attr = attr.to_s
    model_key = self.name.underscore
    versions = ["activerecord.attributes.#{attr}", "activerecord.attributes.#{model_key}.#{attr}"]
    res = nil
    versions.reverse.each do |v|
      res = I18n.t(v, raise: true) rescue nil
      if res.present?
        break
      end
    end

    if res.blank?
      res = attr.humanize
    end

    res
  end
end

ActiveRecord::Base.send(:extend, NameHelper)