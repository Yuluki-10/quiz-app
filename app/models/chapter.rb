class Chapter < ApplicationRecord
  validates :chapter_title, presence: true
  validates :chapter_num, presence: true
  belongs_to :training
  has_many :questions, dependent: :destroy
  # 問題文をAction Textで扱えるようにする
  has_rich_text :content
end
