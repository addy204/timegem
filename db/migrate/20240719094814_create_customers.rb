# frozen_string_literal: true

# db/migrate/xxxx_create_customers.rb
class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.references :user, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true
      t.timestamps
    end
  end
end
