class CreateArticleRelations < ActiveRecord::Migration
  def change
    create_table :article_relations do |t|
      t.integer :article_id
      t.integer :related_article_id
    end

    add_index(:article_relations, [:article_id, :related_article_id], :unique => true)
    add_index(:article_relations, [:related_article_id, :article_id], :unique => true)
  end
end
