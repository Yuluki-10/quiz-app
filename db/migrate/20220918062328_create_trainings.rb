class CreateTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :trainings do |t|
      t.string :title, null: false
      t.integer :categories

      t.timestamps
    end
  end
end
