require 'rails_helper'

RSpec.describe "Scores", type: :request do

  describe "GET /show" do
    it "gets score" do
      player = Player.create(name: "Edo")
      current_time = Time.current.strftime("%Y%m%d %H:%M")
      score = player.scores.create(score: 100, time: current_time)
      get score_url(score.id), headers: { "ACCEPT" => "application/json" }

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:success)

      expect(response.body).to eq({ player: player.name, score: score.score, time: current_time }.to_json)
    end
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

  describe "DELETE /destroy" do
    it "deletes scores by id" do
      headers = { "ACCEPT" => "application/json" }
      player = Player.create(name: "Edo")
      current_time = Time.current.strftime("%Y%m%d %H:%M")
      score = player.scores.create(score: 100, time: current_time)
      delete score_url(score.id), :headers => headers

      expect(Score).to_not exist
    end
  end
end
