class CreateWeatherData < ActiveRecord::Migration
  def up
    Cms.create_weather_data_table
  end

  def down
    Cms.drop_weather_data_table
  end
end
