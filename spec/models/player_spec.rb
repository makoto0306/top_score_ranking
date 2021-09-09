require "rails_helper"

RSpec.describe Player, :type => :model do
  context "create" do
    it 'capitalize names' do
      Player.create(name: "EDO")
      expect(Player.first.name).to eq 'Edo'
    end
  end
end
