class CreateCmsSitemapElements < ActiveRecord::Migration
  def up
    Cms.create_tables only: [:sitemap_elements]
  end

  def down
    Cms.drop_tables only: [:sitemap_elements]
  end
end
