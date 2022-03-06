require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:questions).inverse_of(:asker).dependent(:destroy) }
    it { is_expected.to have_many(:answers).inverse_of(:answerer).dependent(:destroy) }
  end
end
