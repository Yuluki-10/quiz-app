class Question < ApplicationRecord
  belongs_to :training
  has_many :user_answers, dependent: :destroy
  has_many :choices, dependent: :destroy
  # ネストしたモデルを保存するメソッド。非推奨というわけではないが、複雑な処理になるなら「Formオブジェクト」で処理する方が良いかも…
  accepts_nested_attributes_for :choices , allow_destroy: true, reject_if: :all_blank
  validates :content, presence: true
  validates :number, presence: true

end
