class PlayersHistoryController < ApplicationController
  def show
    player = Player.find_by(name: params[:id])
    scores = player.scores.order(:time)
    render json: {
      top_score: scores.maximum(:score),
      low_score: scores.minimum(:score),
      average_score: scores.average(:score).to_f,
      all_scores: scores.map do |s|
        {
          time: s.time.strftime('%Y-%m-%d %H:%M'),
          score: s.score
        }
      end
    }.to_json
  end
end
