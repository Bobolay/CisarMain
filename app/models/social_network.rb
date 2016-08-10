class SocialNetwork < ActiveRecord::Base
  attr_accessible *attribute_names
  scope :published, -> { where(published: 't') }
  scope :sort_by_sorting_position, -> { order("sorting_position asc") }

  image :icon

  globalize :profile_tooltip, :share_tooltip

  def profile_url
    url = self['profile_url']
    if url.present?
      if url.scan(/\A(http\:|https:)\/\//).blank?
        return "//#{url}"
      end
    end

    url
  end
end
