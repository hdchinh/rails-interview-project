require "rails_helper"

RSpec.describe Question, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:asker).class_name("User") }
    it { is_expected.to have_many(:answers).dependent(:destroy) }
  end

  describe ".published" do
    let!(:private_question) { create(:private_question) }
    let!(:publish_question) { create(:publish_question) }

    it "gets published questions only" do
      expect(Question.published.pluck(:id)).to eq([publish_question.id])
    end
  end
end
