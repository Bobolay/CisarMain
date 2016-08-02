class CreateCmsFormConfigs < ActiveRecord::Migration
  def up
    Cms.create_tables only: [:form_configs]
  end

  def down
    Cms.drop_tables only: [:form_configs]
  end
end
