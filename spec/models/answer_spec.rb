require "rails_helper"

RSpec.describe Answer, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:answerer).class_name("User").inverse_of(:answers) }
    it { is_expected.to belong_to(:question) }
  end
end
