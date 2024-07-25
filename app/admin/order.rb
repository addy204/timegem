ActiveAdmin.register Order do
  index do
    selectable_column
    id_column
    column :user
    column "Products" do |order|
      order.order_items.map { |item| "#{item.product.name} (x#{item.quantity})" }.join(", ")
    end
    column "Taxes" do |order|
      order.calculate_taxes
    end
    column :total
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row "Taxes" do |order|
        order.calculate_taxes
      end
      row :total
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column "Product" do |item|
          item.product.name
        end
        column :quantity
        column :price
      end
    end
  end
end
