# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
99.times do |n|
  name = Faker::Name.name
  email = "test-#{n+1}@gmail.com"
  password = "1"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end