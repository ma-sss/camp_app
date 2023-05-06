# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do |i|
    Admin.create!(
        password: "password",
        name: "キャンプ場#{i}",
        address: "東京",
        telephone_number: "000-0000-0000",
        email: "test#{i}@example.com"
    )
    User.create!(
        password: "password",
        email: "test#{i}@example.com"
    )
end
