class PreloginUsersController < ApplicationController
  skip_before_action :check_auth

  def index
    @all_games = Game.where(archived: false)
    render json: @all_games[1..-1]
  end

  def load
    if Redis.current.exists(params[:name])
      render json: Redis.current.get(params[:name])
      @game = Game.find_by(name: params[:name])
      Redis.current.expire(@game.name, 2592000)
    else
      @game = Game.find_by(name: params[:name])
      if !@game.nil?
        Redis.current.set(@game.name, @game.attributes.to_json)
        Redis.current.expire(@game.name, 2592000)
        render json: @game
      else
        render :json => { errors: 'this game does not exist' }, status: 400
      end
    end
  end
end
