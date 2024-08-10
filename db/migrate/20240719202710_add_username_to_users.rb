# frozen_string_literal: true

class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    return if column_exists?(:users, :username)

    add_column :users, :username, :string, unique: true
  end
end
