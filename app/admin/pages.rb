# app/admin/pages.rb

ActiveAdmin.register Page do
  permit_params :title, :content

  form do |f|
    f.inputs do
      f.input :title
      f.input :content # Remove `as: :text_area` and let ActiveAdmin handle it
    end
    f.actions
  end
end
