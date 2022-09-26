class Question < ApplicationRecord
  belongs_to :training
  has_many :choices
  accepts_nested_attributes_for :choices
end
