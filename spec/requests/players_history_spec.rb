require 'rails_helper'

RSpec.describe "PlayersHistory", type: :request do
  describe "GET /show" do
    before do
      player = Player.create(name: 'Edo')
      Score.create(player: player, score: 10, time: Time.zone.local(2021, 9, 10, 10))
      Score.create(player: player, score: 30, time: Time.zone.local(2021, 9, 12, 8))

      Score.create(player: player , score: 90, time: Time.zone.local(2021, 9, 11, 19))
      Score.create(player: player , score: 80, time: Time.zone.local(2021, 9, 13, 10))

      player2 = Player.create(name: 'Edo2')
      Score.create(player: player2 , score: 1000, time: Time.zone.local(2021, 9, 11, 19))
    end

    it 'gets player history' do
      get players_history_url('Edo'), headers: { "ACCEPT" => "application/json" }

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)
      expect(body["top_score"]).to eq(90)
      expect(body["low_score"]).to eq(10)
      expect(body["average_score"]).to eq((10 + 30 + 90 + 80) / 4.0)
      expect(body["all_scores"].first).to eq({ "score" => 10, "time" => '2021-09-10 10:00'})
      expect(body["all_scores"].last).to eq({ "score" => 80, "time" => '2021-09-13 10:00'})
    end
  end
end
