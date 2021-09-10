class ScoresController < ApplicationController

  def index
    scores = Score.filter(
      players: params[:players].split(","),
      before: params[:before],
      after: params[:after],
      page: params[:page],
      limit: params[:limit]
    )

    formatted_scores = scores.map do |s|
      { id: s.id, player: s.player.name,  score: s.score, time: s.time.strftime('%Y-%m-%d %H:%M') }
    end

    render json: formatted_scores.to_json
  end

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

  def destroy
    Score.find(params[:id]).destroy
  end
end
