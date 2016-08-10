class AddJsonDataToCmsPages < ActiveRecord::Migration
  def change
    add_column :pages, :json_data, :text
  end
end
