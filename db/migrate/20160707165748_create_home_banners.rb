class CreateHomeBanners < ActiveRecord::Migration
  def up
    create_table :home_banners do |t|
      t.boolean :published
      t.integer :sorting_position
      t.string :label
      t.string :name
      t.text :short_description
      t.belongs_to :article
      t.attachment :image

      t.timestamps null: false
    end

    HomeBanner.initialize_globalize
    HomeBanner.create_translation_table!(label: :string, name: :string, short_description: :text)


  end

  def down
    HomeBanner.drop_translation_table!
    drop_table :home_banners
  end
end
