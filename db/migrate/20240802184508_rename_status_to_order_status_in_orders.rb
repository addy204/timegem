class RenameStatusToOrderStatusInOrders < ActiveRecord::Migration[7.0]
  def change
    # Rename existing status column to preserve its values
    rename_column :orders, :status, :status_old

    # Add a new integer column for order status with a default value
    add_column :orders, :order_status, :integer, default: 0

    # Map old status values to new enum values
    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          UPDATE orders SET order_status =
          CASE
            WHEN status_old = 'unpaid' THEN 0
            WHEN status_old = 'paid' THEN 1
            WHEN status_old = 'shipped' THEN 2
            ELSE 0
          END
        SQL
      end

      dir.down do
        # Rollback code to set order_status to its original string
        execute <<-SQL.squish
          UPDATE orders SET status_old =
          CASE
            WHEN order_status = 0 THEN 'unpaid'
            WHEN order_status = 1 THEN 'paid'
            WHEN order_status = 2 THEN 'shipped'
            ELSE 'unpaid'
          END
        SQL
      end
    end

    # Remove the old status column
    remove_column :orders, :status_old, :string
  end
end
