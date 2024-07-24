ActiveAdmin.register Page do
  permit_params :title, :content

  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :quill_editor # Use a rich text editor if available
    end
    f.actions
  end
end
