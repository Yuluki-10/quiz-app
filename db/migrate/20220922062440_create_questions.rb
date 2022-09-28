class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :content, null: false
      t.references :training, null: false, foreign_key: true
      t.integer :number, null: false, default: 0

      t.timestamps
    end
  end
end
