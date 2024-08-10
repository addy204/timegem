# frozen_string_literal: true

class ChangeTotalToDecimalInOrders < ActiveRecord::Migration[7.1]
  def change
    change_column :orders, :total, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
