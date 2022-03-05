class AddIndexToPrivateQuestions < ActiveRecord::Migration[6.0]
  def change
    add_index :questions, :private
  end
end
