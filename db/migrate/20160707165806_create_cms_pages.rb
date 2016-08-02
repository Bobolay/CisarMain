class CreateCmsPages < ActiveRecord::Migration
  def up
    Cms.create_tables only: [:pages]
  end

  def down
    Cms.drop_tables only: [:pages]
  end
end
