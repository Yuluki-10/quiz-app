class Question < ApplicationRecord
  belongs_to :chapter
  has_many :user_answers, dependent: :destroy
  has_many :user, through: :user_answers
  has_many :choices, dependent: :destroy
  # ネストしたモデルを保存するメソッド。非推奨というわけではないが、複雑な処理になるなら「Formオブジェクト」で処理する方が良いかも…
  accepts_nested_attributes_for :choices , allow_destroy: true, reject_if: :all_blank
  validates :content, presence: true
  validates :number, presence: true

  # 問題文をAction Textで扱えるようにする
  has_rich_text :content

  # scope機能。現在のユーザーが回答済みかフラグを立てれるか？
  scope :current_user_answered, ->(userid) {
    # 中間テーブルであるuser_answerに、現在のユーザーのidがあるか
    joins(:user_answers).where(
      # chapters_controller.rbで、対象のチャプターに紐づいているもののみに限定済み
      user_answers: {user_id: userid}
    )
  }

  # currentユーザーが未回答の問題
  scope :unanswered, ->(userid) {
    # currentユーザーが答えていれば除外する
    where.missing(:user_answers) || 
    joins(:user_answers).where.not(
      user_answers: {user_id: userid}
    )
  }

end
