# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_803_065_819) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'action_text_rich_texts', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'body'
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[record_type record_id name], name: 'index_action_text_rich_texts_uniqueness', unique: true
  end

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource'
  end

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'addresses', force: :cascade do |t|
    t.bigint 'customer_id', null: false
    t.string 'address_line_1'
    t.string 'address_line_2'
    t.string 'city'
    t.string 'province'
    t.string 'postal_code'
    t.string 'country'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'province_id', null: false
    t.index ['customer_id'], name: 'index_addresses_on_customer_id'
    t.index ['province_id'], name: 'index_addresses_on_province_id'
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'customers', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.bigint 'province_id', null: false
    t.index ['province_id'], name: 'index_customers_on_province_id'
    t.index ['user_id'], name: 'index_customers_on_user_id'
  end

  create_table 'order_items', force: :cascade do |t|
    t.bigint 'order_id', null: false
    t.bigint 'product_id', null: false
    t.integer 'quantity'
    t.decimal 'price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.decimal 'price_at_order', precision: 10, scale: 2
    t.index ['order_id'], name: 'index_order_items_on_order_id'
    t.index ['product_id'], name: 'index_order_items_on_product_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.bigint 'customer_id', null: false
    t.decimal 'total', precision: 10, scale: 2, default: '0.0'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'stripe_payment_id'
    t.string 'stripe_customer_id'
    t.integer 'order_status', default: 0
    t.decimal 'gst_at_order', precision: 5, scale: 2
    t.decimal 'pst_at_order', precision: 5, scale: 2
    t.decimal 'hst_at_order', precision: 5, scale: 2
    t.index ['customer_id'], name: 'index_orders_on_customer_id'
  end

  create_table 'pages', force: :cascade do |t|
    t.string 'title'
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.decimal 'price'
    t.integer 'stock_quantity'
    t.bigint 'category_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'on_sale', default: false
    t.index ['category_id'], name: 'index_products_on_category_id'
  end

  create_table 'provinces', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'static_pages', force: :cascade do |t|
    t.string 'title'
    t.text 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'tax_rates', force: :cascade do |t|
    t.string 'province'
    t.decimal 'gst'
    t.decimal 'pst'
    t.decimal 'hst'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'province_id'
    t.index ['province_id'], name: 'index_tax_rates_on_province_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'username'
    t.bigint 'province_id', null: false
    t.string 'address'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['province_id'], name: 'index_users_on_province_id'
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['username'], name: 'index_users_on_username', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'addresses', 'customers'
  add_foreign_key 'customers', 'users'
  add_foreign_key 'order_items', 'orders'
  add_foreign_key 'order_items', 'products'
  add_foreign_key 'orders', 'customers'
  add_foreign_key 'products', 'categories'
end
