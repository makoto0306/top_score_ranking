require 'rails_helper'

RSpec.describe "Scores", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end

  describe "POST /create" do
    context "valid" do
      it 'responds created' do
        headers = { "ACCEPT" => "application/json" }
        post "/scores", params: { player: "Edo", score: 21, time: "2021-09-09 09:09:09"}, :headers => headers

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:created)
      end
    end

    context "invalid" do

      it 'responds bad request' do
        headers = { "ACCEPT" => "application/json" }
        post "/scores", params: { player: "Edo", score: "abc", time: "2021-09-09 09:09:09"}, :headers => headers
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
