require "rails_helper"

RSpec.describe Score, :type => :model do

  describe '.filter' do
    before do
      player1 = Player.create(name: 'Player1')
      score1 = Score.create(player:  player1 , score: 10, time: Time.zone.local(2021, 9, 10, 10))
      score2 = Score.create(player:  player1 , score: 30, time: Time.zone.local(2021, 9, 12, 8))

      player2 = Player.create(name: 'Player2')
      score3 = Score.create(player: player2 , score: 90, time: Time.zone.local(2021, 9, 11, 19))
      score4 = Score.create(player: player2 , score: 80, time: Time.zone.local(2021, 9, 13, 10))
    end


    context 'filter by player names' do
      it 'filter by specific player' do
        results = Score.filter(players: ['Player2'])
        expect(results.count).to eq 2
        expect(results.first.player.name).to eq 'Player2'
        expect(results.last.player.name).to eq 'Player2'
      end
    end

    it 'filter by only before time' do
      results = Score.filter(before: '2021-09-12')
      expect(results.count).to eq 2

      results = Score.filter(before: '2021-09-13')
      expect(results.count).to eq 3
    end

    it 'filter by only after time' do
      results = Score.filter(after: '2021-09-09')
      expect(results.count).to eq 4

      results = Score.filter(after: '2021-09-11')
      expect(results.count).to eq 2
    end

    it 'filter by before time and after time' do
      results = Score.filter(after: '2021-09-09', before: '2021-09-11')
      expect(results.count).to eq 1
      expect(results.last.score).to eq 10

      results = Score.filter(after: '2021-09-11', before: '2021-09-13')
      expect(results.count).to eq 1
      expect(results.last.score).to eq 30
    end

    it 'filter by page and limit' do
      results = Score.filter(limit: 1, page: 3)
      expect(results.first.score).to eq Score.order(:id).third.score

      results = Score.filter(limit: 3, page: 2)
      expect(results.first.score).to eq Score.order(:id).fourth.score
    end
  end
end
