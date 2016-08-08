class AddLinkableToHomeBanners < ActiveRecord::Migration
  def change
    change_table :home_banners do |t|
      t.linkable
    end
  end
end
