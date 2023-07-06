# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
regular_user1 = User.create(username: 'Lokesh', email: 'lokeshkumarchaman@gmail.com', password: 'password')
regular_user2 = User.create(username: 'Jabra Ram', email: 'jrchoudhary2410@gmail.com', password: 'password')
regular_user3 = User.create(username: 'Mahfuz', email: 'mahfuzflamedestiny@gmail.com', password: 'password')
admin = User.create(username: 'Admin', email: 'admin@gmail.com', password: 'password', admin: true)

category1 = Category.create(category: 'Real Estate')
category2 = Category.create(category: 'Cars')
category3 = Category.create(category: 'Electronics')
category4 = Category.create(category: 'Furniture')
category5 = Category.create(category: 'Books')
category6 = Category.create(category: 'Services')

item1 = Item.create(title: 'Arduino', description: 'Brand new arduino for sell ', username: 'Lokesh', phone: '8756657656',
                    city: 'Kolkata', category_id: category3.id, approved: true, user_id: regular_user1.id, approved_by_id: admin.id)
image_paths = ['arduino_1.jpg', 'arduino_2.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  item1.images.attach(io: File.open(path), filename: image_path)
end

item2 = Item.create(title: 'Audi A4', description: 'Audi A4 2018 model 4 months used', username: 'Jabra Ram',
                    phone: '8756657656', city: 'Kolkata', category_id: category2.id, approved: true, user_id: regular_user2.id, approved_by_id: admin.id)
image_paths = ['audi_a4_1.jpg', 'audi_a4_2.jpg', 'audi_a4_3.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  item2.images.attach(io: File.open(path), filename: image_path)
end

item3 = Item.create(title: ' Physocology of Money', description: 'Book for youngsters to be financially independent',
                    username: 'Mahfuz Alam', phone: '8756657656', city: 'Jaipur', category_id: category5.id, approved: true, user_id: regular_user3.id, approved_by_id: admin.id)
image_paths = ['book_1.jpg', 'book_2.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  item3.images.attach(io: File.open(path), filename: image_path)
end

item4 = Item.create(title: ' 4BHK Villa', description: 'Best for joint family', username: 'Lokesh', phone: '8756657656',
                    city: 'Jaipur', category_id: category1.id, approved: true, user_id: regular_user1.id, approved_by_id: admin.id)
image_paths = ['real-estate1.jpg', 'real-estate3.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  item4.images.attach(io: File.open(path), filename: image_path)
end

item5 = Item.create(title: ' Sofa', description: 'Comfortable and relaxing', username: 'Jabra Ram', phone: '8756657656',
                    city: 'Kolkata', category_id: category4.id, approved: true, user_id: regular_user2.id, approved_by_id: admin.id)
image_paths = ['sofa_1.jpg', 'sofa_2.jpg', 'sofa_3.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  item5.images.attach(io: File.open(path), filename: image_path)
end

item6 = Item.create(title: 'Hondacity', description: 'Contact us for Serivces', username: 'Jabra Ram', phone: '8756657656',
                    city: 'Kolkata', category_id: category6.id, approved: true, user_id: regular_user2.id, approved_by_id: admin.id)
image_paths = ['hondacity.jpg']
image_paths.each do |image_path|
  path = Rails.root.join('app', 'assets', 'images', image_path)
  item6.images.attach(io: File.open(path), filename: image_path)
end
