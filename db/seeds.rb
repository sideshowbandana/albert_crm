# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# if Rails.env.development?
if ENV["ADMIN_EMAIL"] || Rails.env.development?
  email = ENV.fetch("ADMIN_EMAIL", "admin@example.com")
  AdminUser.find_or_create_by(email: email) do |admin|
    pw = ENV.fetch("ADMIN_PASSWORD", "password")
    admin.password = pw
    admin.password_confirmation = pw
    puts "created admin: #{email}"
  end
end
# end

# db/seeds.rb
email_template = EmailTemplate.find_or_create_by(name: 'welcome') do |template|
  template.subject = "Hi <%= name %> Welcome to Albert"
  template.body = "Dear <%= name %>,\n\nSo glad to have you on board!"
  puts "Created email template: #{template.name}"
end
