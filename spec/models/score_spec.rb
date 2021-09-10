require "rails_helper"

RSpec.describe Score, :type => :model do

  describe '.filter' do
    before do
      @currentTime = Time.current
      player1 = Player.create(name: 'Player1')
      score1 = Score.create(player:  player1 , score: 10, time: @currentTime)
      score2 = Score.create(player:  player1 , score: 30, time: @currentTime + 2000)

      player2 = Player.create(name: 'Player2')
      score3 = Score.create(player: player2 , score: 90, time: @currentTime + 1000)
      score4 = Score.create(player: player2 , score: 80, time: @currentTime + 3000)


      # arguments is, multiple names, before, after, offset, limit
    end

    it 'filter by player names' do
      results = Score.filter(players: ['Player2'])
      expect(results.count).to eq 2
      expect(results.first.player.name).to eq 'Player2'
      expect(results.last.player.name).to eq 'Player2'
    end

    it 'filter by only before time' do
      results = Score.filter(before: @currentTime + 1010)
      expect(results.count).to eq 2

      results = Score.filter(before: @currentTime + 2010)
      expect(results.count).to eq 3
    end

    it 'filter by only after time' do
      results = Score.filter(after: @currentTime - 1)
      expect(results.count).to eq 4

      results = Score.filter(after: @currentTime + 1900)
      expect(results.count).to eq 2

    end

    it 'filter by before time and after time' do
      results = Score.filter(after: @currentTime - 1, before: @currentTime + 999)
      expect(results.count).to eq 1
      expect(results.last.score).to eq 10

      results = Score.filter(after: @currentTime + 1000, before: @currentTime + 2000)
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
