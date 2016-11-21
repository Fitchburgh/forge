class PreloginUsersController < ApplicationController
  skip_before_action :check_auth

  def index
    @all_games = Game.where("archived = ? AND published = ?", false, true)
    games = []
    @all_games[1..-1].each do |game|
      games << { id: game.id, name: game.name, tags: game.tags, user_id: game.user_id, description: game.description, published: game.published, plays: game.plays }
    end
    render json: games
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

  # call this immediately after every load action
  def count
    @game = Game.find_by(id: params[:id])
    @game.plays = @game.plays + 1
    @game.save!
    render json: { id: @game.id, name: @game.name, tags: @game.tags, user_id: @game.user_id, description: @game.description, published: @game.published, plays: @game.plays }
  end

  def welcome
  end
end
