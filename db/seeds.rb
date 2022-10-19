# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  3.times do |n|
    User.create!(
      name: "user#{n + 1}",
      email: "#{n + 1}@mail.com",
      password: "userpass#{n + 1}"
    )
  end
  Training.create!(
    [
      {
        title: "初めての動画制作"
      },
      {
        title: "figmaのトレーニング"
      }
    ]
  )
  3.times do |n|
    Chapter.create!(
      training_id: Training.first.id,
      chapter_title: "第#{n}章のタイトルです",
      url: "https://youtu.be/embed/Vf07C_-rbKM",
      chapter_num: n
    )
  end
end