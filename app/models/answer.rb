class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :answerer, foreign_key: "user_id", class_name: "User", inverse_of: :answers
end
