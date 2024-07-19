class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:users, :username)
      add_column :users, :username, :string, unique: true
    end
  end
end
