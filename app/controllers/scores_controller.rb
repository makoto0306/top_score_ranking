class ScoresController < ApplicationController

  def create
    player = Player.find_or_create_by(name: params[:player])
    if player.valid?
      score = player.scores.create(score: params[:score], time: params[:time])
      status = score.valid? ? :created : :bad_request
    end

    render json: { success: player.valid? }, status: status
  end

end
