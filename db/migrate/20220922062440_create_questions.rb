class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      # t.text :content, null: false => ActionTextで保存するので、カラムを追加しなくて良い
      t.references :chapter, null: false, foreign_key: true
      t.integer :number, null: false, default: 0

      t.timestamps
    end
  end
end
