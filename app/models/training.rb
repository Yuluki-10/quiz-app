class Training < ApplicationRecord
  validates :title, presence: true
  has_many :questions
end
