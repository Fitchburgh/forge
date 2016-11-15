require 'pry'
#
class GamesController < ApplicationController
  def index
    @all_games = Game.all
    render json: @all_games
  end

  def create
    @game = Game.new(
      name: params[:name].downcase,
      tags: params[:tags].downcase,
      description: params[:description].downcase,
      obj: params[:obj],
      user_id: params[:user_id].downcase
    )
    if @game.save
      render :json => @game
    else
      render :json => { :errors => @game.errors.full_messages }, status: 406
    end
  end

  def update
    @game = Game.find_by(id: params[:id])

    @game.name = params[:name].downcase
    @game.tags = params[:tags].downcase
    @game.description = params[:description].downcase
    @game.obj = params[:obj]
    if @game.save
      render :json => @game
    else
      render :json => { :errors => @savegame.errors.full_messages }, status: 404
    end
  end

  def delete
    @game = Game.find_by(id: params[:id])
    if @game.nil?
      render :json => { error: 'game not detected' }, status: 404
    else
      render :json => { message: 'game deleted' } if @game.delete
    end
  end

  def search
    @games = []
    games = Game.all
    games.each do |t|
      @games << t if t.tags.include?(params[:tags].downcase) || t.name.include?(params[:tags].downcase)
    end
    render :json => @games
  end

  def find_user_games
    user_games = Game.where(user_id: params[:user_id])
    if user_games.empty?
      render :json => { error: 'user has no games' }, status: 404
    else
      render :json => user_games
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
      render :json => @savegame
    else
      render :json => { :errors => @savegame.errors.full_messages }
    end
  end

  def welcome
  end
end
