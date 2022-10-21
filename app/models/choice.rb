class Choice < ApplicationRecord
  belongs_to :question
  has_many :user_answers, dependent: :destroy
  validates :content, presence: true
  
  # scopeメソッド。choice.correctedで正解解答を呼び出せる
  scope :corrected, ->{
    where(is_answer: true)
  }
end