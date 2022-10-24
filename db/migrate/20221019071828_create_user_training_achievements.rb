class CreateUserTrainingAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :user_training_achievements do |t|
      t.integer :achievement_times, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :training, null: false, foreign_key: true

      t.timestamps
    end
  end
end
