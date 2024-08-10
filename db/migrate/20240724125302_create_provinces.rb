# frozen_string_literal: true

class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    return if table_exists?(:provinces)

    create_table :provinces do |t|
      t.string :name

      t.timestamps
    end
  end
end
