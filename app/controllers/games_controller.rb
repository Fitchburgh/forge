require 'pry'
#
class GamesController < ApplicationController
  # Redis for : create, update, delete - set, set, delete
  # render json: Redis.current.get('keyname') to return

  def index
    @all_games = Game.all
    render json: @all_games
  end

  def create
    @game = Game.new(
      name: params[:name].downcase,
      tags: params[:tags].to_s.downcase,
      description: params[:description].downcase,
      obj: params[:obj],
      user_id: params[:user_id]
    )
    if @game.save
      Redis.current.set(@game.name, @game.attributes.to_json)
      render :json => { game: [@game.id, @game.name, @game.tags, @game.description, @game.user_id] }
    else
      render :json => { :errors => @game.errors.full_messages }, status: 400
    end
  end

  def update # Redis.current.set after save new game
    @game = Game.find_by(id: params[:id])

    @game.name = params[:name].downcase
    @game.tags = params[:tags].downcase
    @game.description = params[:description].downcase
    @game.obj = params[:obj]
    if @game.save
      render :json => { game: [@game.id, @game.name, @game.tags, @game.description, @game.user_id] }
    else
      render :json => { :errors => @savegame.errors.full_messages }, status: 404
    end
  end

  def delete
    @game = Game.find_by(id: params[:id])
    if !@game.nil?
      if @game.user_id == params[:user_id].to_i
        render :json => { message: 'game deleted' } if @game.delete
      else
        render :json => { error: 'only the creator can delete this game' }, status: 400
      end
    else
      render :json => { error: 'game not detected' }, status: 404
    end
  end

  def search
    @games = []
    games = Game.all
    games.each do |t|
      if t.tags.include?(params[:tags].downcase) || t.name.include?(params[:tags].downcase)
        @games << {id: t.id, name: t.name, tags: t.tags, user_id: t.user_id, description: t.description, created_at: t.created_at}
      end
    end
    render json: @games
  end

  def find_user_games
    user_games = Game.where(user_id: params[:user_id])
    if user_games.empty?
      render json: []
      # render :json => { error: 'user has no games' }, status: 404
    else
      render json: user_games
    end
  end

  def savegame
    # need to automatically populate user_id and game_id fields
    @savegame = SaveGame.new(
      game_id: params[:game_id],
      user_id: params[:user_id],
      obj: params[:obj]
    )
    if @savegame.save
      render json: @savegame
    else
      render :json => { :errors => @savegame.errors.full_messages }, status: 400
    end
  end

  def welcome
  end
end
