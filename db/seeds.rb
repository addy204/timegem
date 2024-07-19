require 'csv'

# Ensure the existence of the admin user
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Import categories
CSV.foreach(Rails.root.join('db/seeds/categories.csv'), headers: true) do |row|
  Category.find_or_create_by!(
    name: row['name'],
    description: row['description']
  )
end

# Import products
CSV.foreach(Rails.root.join('db/seeds/products.csv'), headers: true) do |row|
  category = Category.find_by(name: row['category'])
  Product.find_or_create_by!(
    name: row['name'],
    description: row['description'],
    price: row['price'],
    stock_quantity: row['stock_quantity'],
    category: category
  )
end
