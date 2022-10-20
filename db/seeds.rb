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
        title: "初めての在宅ワーク"
      },
      {
        title: "ライティングの基礎"
      },
      {
        title: "デザインの基礎からバナー制作まで"
      }
    ]
  )
  chapter_titles = ["COMOLYで請け負った動画の種類", "動画編集で必要なPCスペック", "動画編集ソフトの紹介", "動画編集の基本的なやり方", "実践ワークショップ", "まとめ"]
  chapter_titles.each_with_index do |c, i|
    Chapter.create!(
      training_id: Training.first.id,
      chapter_title: c,
      url: "https://www.youtube.com/embed/Vf07C_-rbKM",
      chapter_num: i + 1,
      content: "<h1>動画の概要</h1><div>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<br><br></div><h1>ポイント</h1><div>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<br><br></div><h1>注意点</h1><div>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</div>"
    )
  end
end