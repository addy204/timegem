# frozen_string_literal: true

class AddOnSaleToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :on_sale, :boolean
  end
end
