# frozen_string_literal: true

ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :category_id, images: []

  form do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :category
      row :created_at
      row :updated_at
      row :images do |product|
        ul do
          product.images.each do |image|
            li do
              image_tag url_for(image)
            end
          end
        end
      end
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :category
    actions
  end

  filter :name
  filter :description
  filter :price
  filter :stock_quantity
  filter :category
  filter :created_at
  filter :updated_at
end
