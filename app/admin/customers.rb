# app/admin/customers.rb
ActiveAdmin.register Customer do
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :orders_count do |customer|
      customer.orders.size
    end
    actions
  end

  filter :name
  filter :email
  filter :created_at

  show do
    attributes_table do
      row :name
      row :email
      row :created_at
      row :updated_at
    end

    panel "Orders" do
      table_for customer.orders do
        column :id
        column :status
        column :subtotal do |order|
          number_to_currency(order.subtotal)
        end
        column :taxes do |order|
          number_to_currency(order.calculate_taxes)
        end
        column :total do |order|
          number_to_currency(order.total)
        end
      end
    end
  end

  permit_params :name, :email, :province_id, addresses_attributes: [:id, :address_line_1, :address_line_2, :city, :postal_code, :country, :province_id, :_destroy]
end
