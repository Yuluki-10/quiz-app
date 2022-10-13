class Training < ApplicationRecord
  validates :title, presence: true
  has_many :questions, dependent: :destroy
  # 問題文をAction Textで扱えるようにする
  has_rich_text :content
end
