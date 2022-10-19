class Training < ApplicationRecord
  validates :title, presence: true
  has_many :questions, dependent: :destroy
  has_many :chapters, dependent: :destroy
  has_many :user_training_achievements, dependent: :destroy
end
