class ContactInfo < ActiveRecord::Base
  attr_accessible *attribute_names
  globalize :address

  def phones
    self['phones'].split("\r\n")
  end

  def emails
    self['emails'].split("\r\n")
  end
end
