class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.boolean :published
      t.string :type
      t.string :name
      t.string :url_fragment
      t.attachment :avatar
      t.datetime :released_on
      t.text :content

      t.timestamps null: false

      t.text :banner_description
      t.text :short_description

      t.string :banner_title
      t.attachment :banner_image
    end

    Article.initialize_globalize
    Article.create_translation_table!(name: :string, url_fragment: :string, short_description: :text, content: :text, banner_description: :text, banner_title: :string)
  end

  def down
    Article.drop_translation_table!

    drop_table :articles
  end

end
