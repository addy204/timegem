class AddUserToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_reference :customers, :user, foreign_key: true
  end
end
