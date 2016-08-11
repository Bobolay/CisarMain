class CreateContactInfos < ActiveRecord::Migration
  def up
    create_table :contact_infos do |t|
      t.string :lat_lg
      t.text :address
      t.text :emails
      t.text :phones
      t.timestamps null: false
    end

    ContactInfo.create_translation_table(:address)
  end

  def down
    ContactInfo.drop_translation_table

    drop_table :contact_infos
  end
end
