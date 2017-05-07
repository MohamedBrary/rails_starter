# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = CreateAdminService.new.call
puts "Created Admin user".colorize(:green)
puts "Login with Admin user to test drive the system, use this email '#{user.email}' and password '#{Rails.application.secrets.admin_password}'".colorize(:red)
