class CreateTaxRates < ActiveRecord::Migration[7.1]
  def change
    create_table :tax_rates do |t|
      t.string :province
      t.decimal :gst
      t.decimal :pst
      t.decimal :hst

      t.timestamps
    end
  end
end
