class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :asker, foreign_key: "user_id", class_name: "User", inverse_of: :questions

  scope :published, -> { where(private: false) }
end
