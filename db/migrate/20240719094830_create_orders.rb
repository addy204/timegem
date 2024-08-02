# db/migrate/xxxx_create_orders.rb
class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :status
      t.decimal :total, precision: 10, scale: 2
      t.timestamps
    end
  end
end
