ActiveAdmin.register TaxRate do
  permit_params :province_id, :gst, :pst, :hst

  index do
    selectable_column
    id_column
    column :province do |tax_rate|
      tax_rate.province&.name # Safe navigation operator to avoid errors if province is nil
    end
    column :gst
    column :pst
    column :hst
    actions
  end

  filter :province

  form do |f|
    f.inputs do
      f.input :province_id, as: :select, collection: Province.all.collect { |p| [p.name, p.id] }, include_blank: false
      f.input :gst
      f.input :pst
      f.input :hst
    end
    f.actions
  end
end
