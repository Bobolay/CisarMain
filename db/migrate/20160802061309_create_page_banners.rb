class CreatePageBanners < ActiveRecord::Migration
  def up
    # create_table :page_banners do |t|
    #   t.string :attachable_type
    #   t.integer :attachable_id
    #   t.string :attachable_field_name
    #
    #   t.attachment :image
    #   t.string :title
    #
    #   t.text :description
    #   t.attachment :info_header_icon
    #   t.string :info_header_text
    #
    #   t.timestamps null: false
    # end

    # Cms.create_banner_table(icon: false, description: true)
    # change_table Cms.config.banner_class.table_name do |t|
    #   t.attachment :info_header_icon
    #   t.string :info_header_text
    # end
    #
    # change_table Cms.config.banner_class.translation_class.table_name do |t|
    #
    # end

    create_table :page_banners do |t|
      t.integer :attachable_id
      t.string :attachable_type

      t.attachment :image
      t.string :title
      t.string :description
      t.attachment :info_header_icon
      t.string :info_header_text
    end

    PageBanner.create_translation_table(:title, :description, :info_header_text)

  end

  def down
    PageBanner.drop_translation_table
    drop_table :page_banners
  end
end
