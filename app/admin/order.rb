ActiveAdmin.register Order do
  index do
    selectable_column
    id_column

    # Customer information
    column :customer do |order|
      if order.customer
        link_to order.customer.name, admin_customer_path(order.customer)
      else
        "No Customer"
      end
    end

    # Order status with status tag
    column :order_status do |order|
      status_tag order.order_status.capitalize
    end

    # Order items listed directly in the index
    column "Order Items" do |order|
      ul do
        order.order_items.each do |item|
          product_name = item.product&.name || "Unknown Product"
          quantity = item.quantity || 0
          price = item.price || 0
          total = number_to_currency(quantity * price)
          li "#{product_name} (Qty: #{quantity}, Total: #{total})"
        end
      end
    end

    # Subtotal, taxes, and total
    column :subtotal do |order|
      number_to_currency(order.subtotal)
    end
    column :taxes do |order|
      number_to_currency(order.calculate_taxes)
    end
    column :total do |order|
      number_to_currency(order.total)
    end

    # Stripe Payment ID
    column :stripe_payment_id

    actions
  end

  show do
    attributes_table do
      row :id
      row :customer do |order|
        link_to order.customer.name, admin_customer_path(order.customer) if order.customer
      end
      row :order_status do |order|
        status_tag order.order_status.capitalize
      end
      row :subtotal do |order|
        number_to_currency(order.subtotal)
      end
      row :taxes do |order|
        number_to_currency(order.calculate_taxes)
      end
      row :total do |order|
        number_to_currency(order.total)
      end
      row :stripe_payment_id
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product do |item|
          item.product&.name || "Unknown Product"
        end
        column :quantity
        column :price do |item|
          number_to_currency(item.price || 0)
        end
        column :total do |item|
          number_to_currency((item.quantity || 0) * (item.price || 0))
        end
      end
    end
  end

  # Filters for convenience
  filter :order_status, as: :select, collection: Order.order_statuses.keys
  filter :customer_name_cont, as: :string, label: 'Customer Name'
  filter :created_at

  # Permit params for editing
  permit_params :customer_id, :order_status, :total, :stripe_payment_id
end
