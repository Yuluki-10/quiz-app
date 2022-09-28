class Choice < ApplicationRecord
  belongs_to :question
  has_many :user_answers, dependent: :destroy
  
  # 回答済みの相談を取得
  scope :corrected, ->{
    where(is_answer: true)
  }
end