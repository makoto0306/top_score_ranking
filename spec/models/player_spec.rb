require "rails_helper"

RSpec.describe Player, :type => :model do
  context "create" do
    it 'capitalize names' do
      Player.create(name: "EDO")
      expect(Player.first.name).to eq 'Edo'
    end
  end

  describe "#average_score" do
    it 'get average score' do
      player = Player.create(name: 'Edo')
      score1 = Score.create(player: player, score: 10, time: Time.zone.local(2021, 9, 10, 10))
      score2 = Score.create(player: player, score: 30, time: Time.zone.local(2021, 9, 12, 8))

      score3 = Score.create(player: player , score: 90, time: Time.zone.local(2021, 9, 11, 19))
      score4 = Score.create(player: player , score: 80, time: Time.zone.local(2021, 9, 13, 10))

      expect(player.average_score).to eq ((10 + 30 + 90 + 80) / 4.0)
    end
  end
  describe 'player histories' do

  end
end
