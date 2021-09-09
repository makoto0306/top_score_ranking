require "rails_helper"

RSpec.describe Player, :type => :model do
  context "create" do
    it 'downcase names' do
      Player.create(name: "EDO")
      expect(Player.first.name).to eq 'edo'
    end

    it 'can create scores at the same time' do
      Player.create(
        name: "EDO", scores_attributes: [{ score: 12, time: "2021-01-01 12:00:05".to_datetime }]
      )
      expect(Player.exists?).to be_truthy
      expect(Score.exists?).to be_truthy
    end
  end
end
