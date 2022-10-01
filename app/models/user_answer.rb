class UserAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :choice
  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :choice_id, presence: true
end
