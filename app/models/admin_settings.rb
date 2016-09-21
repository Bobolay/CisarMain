class AdminSettings < ActiveRecord::Base
  attr_accessible *attribute_names
  #field :default_priority
  field :default_changefreq

  def self.default_changefreq
    first.try(:default_changefreq)
  end
end