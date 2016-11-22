class PreloginUsersController < ApplicationController
  skip_before_action :check_auth

  def index
    @all_games = Game.where("archived = ? AND published = ?", false, true)
    games = []
    @all_games.each do |game|
      username = User.find(game.user_id).username
      games << {
        id: game.id,
        name: game.name,
        tags: game.tags,
        username: username,
        description: game.description,
        published: game.published,
        score: game.score,
        plays: game.plays,
        created_at: game.created_at
      }
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

  def create
    @user = User.create_new_user(@user, params)
    if @user.save
      render json: @user
    else
      render :json => { error: 'User not created' }, status: 400
    end
  end

  def login
    @user = User.find_by uid: params[:uid]
    if @user.nil?
      render :json => 'User does not exist', :status => 404
    else
      @user.token = params[:token]
      @user.save
      render json: @user
    end
  end

  # call this immediately after every load action
  def count
    @game = Game.find_by(id: params[:id])
    @game.plays = @game.plays + 1
    @game.save!
    render json: {
      id: @game.id,
      name: @game.name,
      tags: @game.tags,
      user_id: @game.user_id,
      description: @game.description,
      published: @game.published,
      plays: @game.plays
    }
  end

  def search
    @games = Game.find_game_by_input(@games, params[:name])
    render json: @games
  end

  def welcome
  end
end
