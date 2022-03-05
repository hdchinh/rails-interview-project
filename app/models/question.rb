class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :asker, foreign_key: "user_id", class_name: "User", inverse_of: :questions

  scope :publish, -> { where(private: false) }
end
