# frozen_string_literal: true

# app/admin/pages.rb

ActiveAdmin.register Page do
  permit_params :title, :content

  # Index page customization to show page titles and an excerpt of the content
  index do
    selectable_column
    id_column
    column :title
    column :content do |page|
      truncate(strip_tags(page.content), length: 100) # Show an excerpt of content
    end
    actions
  end

  # Form for creating/editing pages
  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :quill_editor # Assuming you have a rich text editor like Quill
    end
    f.actions
  end

  # Show page customization
  show do
    attributes_table do
      row :title
      row :content do |page|
        page.content.html_safe # Render the content with HTML
      end
    end
    active_admin_comments
  end

  # Filters for searching and sorting pages
  filter :title
  filter :created_at
  filter :updated_at
end
