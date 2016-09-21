class AddContentToPageTranslations < ActiveRecord::Migration
  def change
    if !Cms::Page.column_names.include?("content")
      add_column :page_translations, :content, :text
    end
  end
end
