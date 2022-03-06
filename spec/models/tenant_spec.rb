require "rails_helper"

RSpec.describe Tenant, type: :model do
  describe "callbacks" do
    it { is_expected.to callback(:generate_api_key).before(:create) }
  end

  describe "validations" do
    let(:tenant) { create(:tenant) }

    it "validate uniqueness api_key" do
      expect(tenant).to validate_uniqueness_of(:api_key)
    end

    it "validate uniqueness name" do
      expect(tenant).to validate_uniqueness_of(:name)
    end
  end

  describe "#generate_api_key" do
    let(:tenant) { create(:tenant) }

    before do
      create_list(:tenant, 100)
    end

    it "generates api_key after create" do
      expect(tenant.api_key).not_to be nil
    end

    it "generates unique api_key for each tenant" do
      expect(Tenant.all.map(&:api_key).uniq.size).to eq(Tenant.count)
    end
  end
end
