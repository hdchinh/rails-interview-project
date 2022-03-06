require "rails_helper"

RSpec.describe "/api/questions", type: :request do
  describe "GET /api/questions" do
    let(:url) { "/api/questions" }

    context "when request missing api-key" do
      let(:headers) { { "Accept" => "application/json" } }

      before { get url, headers: headers }

      it "returns :unauthorized status" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when api-key is invalid" do
      let(:headers) { { "Accept" => "application/json", "api-key": SecureRandom.hex(16) } }

      before { get url, headers: headers }

      it "returns :unauthorized status" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when api-key is valid" do
      let!(:tenant) { create(:tenant, access_count: 0) }
      let(:headers) { { "Accept" => "application/json", "api-key": tenant.api_key } }

      before do
        create_list(:private_question, 5)
        create_list(:publish_question, 5)

        get url, headers: headers
      end

      it "returns :ok" do
        expect(response).to have_http_status(:ok)
      end

      it "returns correct format" do
        expect(json_response).to match_json_schema("questions/index")
      end

      it "returns published questions only" do
        expect(json_response["data"].map { |item| item["id"] }.sort).to eq(Question.published.pluck(:id).sort)
      end

      it "increes access_count" do
        expect(tenant.reload.access_count).to eq(1)
      end
    end
  end

  describe "GET /api/questions/:id" do
    let!(:question) { create(:publish_question) }
    let(:url) { "/api/questions/#{question.id}" }

    context "when request missing api-key" do
      let(:headers) { { "Accept" => "application/json" } }

      before { get url, headers: headers }

      it "returns :unauthorized status" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when api-key is invalid" do
      let(:headers) { { "Accept" => "application/json", "api-key": SecureRandom.hex(16) } }

      before { get url, headers: headers }

      it "returns :unauthorized status" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when api-key is valid" do
      let!(:tenant) { create(:tenant, access_count: 0) }
      let(:headers) { { "Accept" => "application/json", "api-key": tenant.api_key } }

      before { get url, headers: headers }

      it "returns :ok" do
        expect(response).to have_http_status(:ok)
      end

      it "returns correct format" do
        expect(json_response).to match_json_schema("questions/show")
      end

      it "increes access_count" do
        expect(tenant.reload.access_count).to eq(1)
      end

      context "when question id is invalid" do
        let!(:question) { create(:private_question) }

        it "returns :not_found" do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
