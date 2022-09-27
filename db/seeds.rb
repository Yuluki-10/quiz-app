# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  User.create!(
    name: "1user",
    email: "1@mail.com",
    password: "1userpass"
  )
  Training.create!(
    title: "figmaのトレーニング①",
    url: "https://www.youtube.com/embed/oMMllsEYUoQ"
  )
  Training.create!(
    title: "figmaのトレーニング②",
    url: "https://www.youtube.com/embed/IvmzDn9uGzs"
  )
end