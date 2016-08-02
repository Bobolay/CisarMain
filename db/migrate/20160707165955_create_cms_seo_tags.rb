class CreateCmsSeoTags < ActiveRecord::Migration
  def up
    Cms.create_tables only: [:seo_tags]
  end

  def down
    Cms.drop_tables only: [:seo_tags]
  end
end
