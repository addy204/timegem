class AddProvinceToUsers < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:users, :province_id)
      add_reference :users, :province, foreign_key: true
    end
    unless column_exists?(:users, :address)
      add_column :users, :address, :string
    end
  end
end
