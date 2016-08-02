class AddFeaturedToDish < ActiveRecord::Migration
  def change
    add_column :dishes, :featured, :boolean
  end
end
