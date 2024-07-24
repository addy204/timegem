class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    unless table_exists?(:provinces)
      create_table :provinces do |t|
        t.string :name

        t.timestamps
      end
    end
  end
end
