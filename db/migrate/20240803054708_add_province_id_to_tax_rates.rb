class AddProvinceIdToTaxRates < ActiveRecord::Migration[7.1]
  def change
    add_reference :tax_rates, :province, foreign_key: true
  end
end
