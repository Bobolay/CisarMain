class AddContentToPageTranslations < ActiveRecord::Migration
  def change
    if !Cms::Page.translation_class.column_names.include?("content")
      add_column :page_translations, :content, :text
    end
  end
end
