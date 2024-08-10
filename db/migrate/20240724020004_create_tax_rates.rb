# frozen_string_literal: true

# db/migrate/xxxx_create_tax_rates.rb
class CreateTaxRates < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_rates do |t|
      t.references :province, foreign_key: true
      t.decimal :gst, precision: 5, scale: 2
      t.decimal :pst, precision: 5, scale: 2
      t.decimal :hst, precision: 5, scale: 2
      t.timestamps
    end
  end
end
