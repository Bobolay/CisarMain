module MailerHelper
  def self.included(base)
    if base.respond_to?(:helper_method)
      [:table_field, :table_field_label].each do |m|
        base.helper_method(m)
      end
    end

  end

  def table_field(name, value)
    ( table_field_label(name, false)+
    content_tag("tr") do
      content_tag "td" do
        value
      end
    end).html_safe
  end

  def table_field_label(name, escape = true)
    res = content_tag("tr") do
      content_tag "td" do
        content_tag("b", name)
      end
    end

    return res if !escape

    res.html_safe
  end
end