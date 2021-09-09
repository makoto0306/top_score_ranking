require "rails_helper"

RSpec.describe Player, :type => :model do
  context "create" do
    it 'capitalize names' do
      Score.create(name: "EDO")
      expect(Score.first.name).to eq 'Edo'
    end
  end
end
