class AddNameToPages < ActiveRecord::Migration
  def change
    add_column :page_translations, :name, :string
  end
end
