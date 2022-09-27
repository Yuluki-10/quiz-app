class CreateChoices < ActiveRecord::Migration[6.1]
  def change
    create_table :choices do |t|
      t.references :question, null: false, foreign_key: true
      t.boolean :is_answer, null: false, default: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
