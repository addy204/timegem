# frozen_string_literal: true

class AddProvinceToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :province, foreign_key: true unless column_exists?(:users, :province_id)
    return if column_exists?(:users, :address)

    add_column :users, :address, :string
  end
end
