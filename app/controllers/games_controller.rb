require 'pry'
#
class GamesController < ApplicationController
  def index
    @all_games = Game.all
    render json: @all_games
  end

  def create
    @game = Game.new(create_game_params)
    if @game.save
      render :json => @game
    else
      render :json => { :errors => @game.errors.full_messages }
    end
  end

  # this action should be to update the entire game json object, never one part
  def update
  end

  def delete
  end

  def play
  end

  def search
    @games = []
    games = Game.all
    games.each do |t|
      @games << t.name if t.tags.include?(params[:tags]) || t.name.include?(params[:tags])
    end
    render :json => @games
    # Right now @games is just the names of the games, we can adjust to send back whatever FE needs
  end

  def savegame
    # need to automatically populate user_id and game_id fields
    @savegame = SaveGame.new(savegame_params)
    if @savegame.save
      render :json => @savegame
    else
      render :json => { :errors => @savegame.errors.full_messages }
    end
  end

  def restore
  end

  def welcome
  end

  private

  def savegame_params
    params.permit(:obj)
  end

  def create_game_params
    params.permit(:name, :tags, :description, :user_id, :obj)
  end

end
