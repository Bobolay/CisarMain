class CreateSocialNetworks < ActiveRecord::Migration
  def up
    create_table :social_networks do |t|
      t.boolean :published
      t.integer :sorting_position
      t.string :key
      t.string :profile_url
      t.attachment :icon

      t.string :profile_tooltip
      t.string :share_tooltip

      t.timestamps null: false
    end

    SocialNetwork.create_translation_table(:profile_tooltip, :share_tooltip)
  end

  def down
    SocialNetwork.drop_translation_table

    drop_table :social_networks
  end
end
