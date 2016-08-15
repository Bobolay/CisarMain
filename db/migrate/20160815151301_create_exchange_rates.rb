class CreateExchangeRates < ActiveRecord::Migration
  def up
    Cms.create_exchange_rates_table
  end

  def down
    Cms.drop_exchange_rates_table
  end
end
