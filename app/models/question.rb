class Question < ApplicationRecord
  belongs_to :training
  has_many :user_answers, dependent: :destroy
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices , allow_destroy: true, reject_if: :all_blank
end
