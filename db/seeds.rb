# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do |i|
    Admin.create!(
        password: "Password123",
        name: "キャンプ場#{i}",
        address: "東京#{i}",
        telephone_number: "090-#{i}000-0000",
        email: "admin_test#{i}@example.com"
    )
    User.create!(
        name: "user#{i}",
        password: "Password123",
        email: "user_test#{i}@example.com"
    )
end
