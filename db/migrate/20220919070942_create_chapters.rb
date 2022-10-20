class CreateChapters < ActiveRecord::Migration[6.1]
  def change
    create_table :chapters do |t|
      t.string :chapter_title, null: false
      t.text :url
      t.integer :chapter_num, null: false, default: 0
      t.references :training, null: false, foreign_key: true

      t.timestamps
    end
  end
end

