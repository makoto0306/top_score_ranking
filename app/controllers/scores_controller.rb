class ScoresController < ApplicationController

  def create
    player = Player.find_or_create_by(name: params[:player])
    if player.valid?
      score = player.scores.create(score: params[:score], time: params[:time])
      status = score.valid? ? :created : :bad_request
    end

    render json: { success: player.valid? }, status: status
  end

  def show
    score = Score.joins(:player).find(params[:id])

    render json: { player: score.player.name, score: score.score, time: score.time.strftime("%Y%m%d %H:%M") }.to_json
  end
end
