module ApplicationHelper
  def pages_menu(page_names = %w(home rooms cafe services events blog contacts) )
    if @menu_pages_entries
      return @menu_pages_entries
    end

    #page_names = %w(home contacts about_us services)
    @pages = page_names.map{|name| Pages.send(name) }

    @menu_pages_entries = @pages.map do |p|
      entry = {}
      entry[:name] = p.name
      entry[:url] = p.url(I18n.locale) || p.default_url
      entry[:active] = @page_instance.try(:url) == entry[:url] || @page_instance.try(:default_url) == p.default_url
      entry[:svg_icon] = p.try(:svg_icon)

      entry
    end

    #compute_navigation_keys(menu_keys, i18n_root)

    @menu_pages_entries
  end

  def main_menu_items()
    recursive_menu(["home", {key: "rooms", children: @rooms}, "services", "cafe", "events", "blog", "contacts"])
    #basic_menu("@sidebar_menu_entries", relation, active)
  end

  def formatted_phone_number(phone)
    last_numbers = phone
    phone = phone.gsub(/\s/, "")
    if !phone.start_with?("+") || !phone.start_with?("38")
      if phone.start_with?("38")
        phone = "+#{phone}"
      else
        phone = "+38#{phone}"
      end
    end

    return phone.gsub(/\+380/, "+38 0").gsub(/[\d]{7}\Z/){" <span>#{$&}</span>"}

    phone.gsub(/\+38/, "<span class='bracket bracket-open'>(</span>").gsub(/\)/, "<span class='bracket bracket-close'>)</span>").html_safe
    #parts = phone.split(/[\(\)]/)

  end


  def booking_department_phones
    ["+38 (032) 253 25 65"]
  end

  def booking_department_emails
    ["cisar.lviv@gmail.com"]
  end

  def sales_department_phones
    ["+38 (094) 993 45 65", "+38 (094) 993 65 65"]
  end

  def sales_department_emails
    ["cisar.lviv@gmail.com"]
  end

  def departments
    [
        { name: "Бронювання", phones: booking_department_phones, emails: booking_department_emails },
        { name: "Продажу", phones: sales_department_phones, emails: sales_department_emails }
    ]
  end
end
