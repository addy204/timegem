# frozen_string_literal: true

# db/seeds.rb
require 'csv'
require 'faker'

# Ensure the existence of the admin user
AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin_user|
  admin_user.password = 'password'
  admin_user.password_confirmation = 'password'
end

# Seed Pages
Page.find_or_create_by!(title: 'About', content: 'About us content goes here.')
Page.find_or_create_by!(title: 'Contact', content: 'Contact us content goes here.')

# Seed Provinces
provinces = [
  'Alberta', 'British Columbia', 'Manitoba', 'New Brunswick', 'Newfoundland and Labrador',
  'Nova Scotia', 'Ontario', 'Prince Edward Island', 'Quebec', 'Saskatchewan',
  'Northwest Territories', 'Nunavut', 'Yukon'
]

provinces.each do |province|
  Province.find_or_create_by!(name: province)
end

# Seed Tax Rates
tax_rates = {
  'Alberta' => { gst: 5, pst: 0, hst: 0 },
  'British Columbia' => { gst: 5, pst: 7, hst: 0 },
  'Manitoba' => { gst: 5, pst: 7, hst: 0 },
  'New Brunswick' => { gst: 0, pst: 0, hst: 15 },
  'Newfoundland and Labrador' => { gst: 0, pst: 0, hst: 15 },
  'Nova Scotia' => { gst: 0, pst: 0, hst: 15 },
  'Ontario' => { gst: 0, pst: 0, hst: 13 },
  'Prince Edward Island' => { gst: 0, pst: 0, hst: 15 },
  'Quebec' => { gst: 5, pst: 9.975, hst: 0 },
  'Saskatchewan' => { gst: 5, pst: 6, hst: 0 },
  'Northwest Territories' => { gst: 5, pst: 0, hst: 0 },
  'Nunavut' => { gst: 5, pst: 0, hst: 0 },
  'Yukon' => { gst: 5, pst: 0, hst: 0 }
}

tax_rates.each do |province, rates|
  TaxRate.find_or_create_by!(province:) do |tr|
    tr.gst = rates[:gst]
    tr.pst = rates[:pst]
    tr.hst = rates[:hst]
  end
end

puts 'Checking if files exist...'

categories_path = Rails.root.join('db/seeds/categories.csv')
products_path = Rails.root.join('db/seeds/products.csv')

puts "Categories CSV: #{File.exist?(categories_path)}"
puts "Products CSV: #{File.exist?(products_path)}"

if File.exist?(categories_path) && File.exist?(products_path)
  puts 'Seeding categories...'
  category_count = 0
  CSV.foreach(categories_path, headers: true) do |row|
    Category.find_or_create_by!(
      name: row['name'],
      description: row['description']
    )
    category_count += 1
  end
  puts "Seeded #{category_count} categories."

  puts 'Seeding products...'
  product_count = 0
  CSV.foreach(products_path, headers: true) do |row|
    category = Category.find_by(name: row['category'])
    if category
      Product.find_or_create_by!(
        name: row['name'],
        description: row['description'],
        price: row['price'],
        stock_quantity: row['stock_quantity'],
        category:,
        on_sale: [true, false].sample # Randomly set on_sale to true or false
      )
      product_count += 1
    else
      puts "Category not found for product: #{row['name']}"
    end
  end
  puts "Seeded #{product_count} products."

  # Seed additional products using Faker if needed
  if product_count < 100
    puts 'Seeding additional products with Faker...'
    categories = Category.all
    (100 - product_count).times do
      category = categories.sample
      Product.create!(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence,
        price: Faker::Commerce.price(range: 100..20_000.0, as_string: true),
        stock_quantity: Faker::Number.between(from: 1, to: 100),
        category:,
        on_sale: [true, false].sample # Randomly set on_sale to true or false
      )
    end
    puts 'Seeded additional products to reach 100 products.'
  end
else
  puts 'CSV files not found.'
end
