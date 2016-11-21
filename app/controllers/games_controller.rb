require 'pry'
class GamesController < ApplicationController
  def create
    @game = Game.create_new_game(@game, params, request.env['HTTP_USER_ID'])
    if @game.save
      Redis.current.set(@game.name, @game.attributes.to_json)
      Redis.current.expire(@game.name, 2592000)
      render json: @game
    else
      render :json => { :errors => @game.errors.full_messages }, status: 400
    end
  end

  def update
    @game = Game.find_by(id: params[:id])

    # I'd like to make this a model method, but we need to return two things:
    # true or false, and if true the name of the game before we update it
    make_new_key = false
    if !(@game.name == params[:name])
      make_new_key = true
      old_name = @game.name
    end

    if !Collaborator.find_by('game_id = ? AND user_id = ?', @game.id, request.env['HTTP_USER_ID']).nil?
      Game.update_game(@game, params)
      if @game.save
        Redis.current.del(old_name) if make_new_key = true
        Redis.current.set(@game.name, @game.attributes.to_json)
        Redis.current.expire(@game.name, 2592000)
        render :json => { id: @game.id, name: @game.name, tags: @game.tags, description: @game.description, user_id: @game.user_id, published: @game.published, plays: @game.plays }
      else
        render :json => { errors: @savegame.errors.full_messages }, status: 404
      end
    else
      render :json => { message: 'only a collaborator can edit a game' }
    end
  end

  def delete
    @game = Game.find_by(id: params[:id])
    if !@game.nil?
      if @game.user_id == request.env['HTTP_USER_ID'].to_i
        @game.archived = true
        @game.archived_at = Time.now.strftime '%Y-%m-%d %H:%M:%S'
        @game.save!
        render :json => { message: 'game archived' }, status: 200
      else
        render :json => { error: 'only the creator can delete this game' }, status: 400
      end
    else
      render :json => { error: 'game not detected' }, status: 404
    end
  end

  def search
    @games = Game.find_game_by_input(@games, params[:name])
    render json: @games
  end

  def find_user_games
    user_games = Game.where(user_id: request.env['HTTP_USER_ID'])
    if user_games.empty?
      render json: []
    else
      games = []
      user_games.each do |game|
        if game.id > 0
          games << { id: game.id, name: game.name, tags: game.tags, user_id: game.user_id, description: game.description, published: game.published, plays: game.plays }
        end
      end
      render json: games
    end
  end

  def find_user_games_count
    user_games = Game.where(user_id: request.env['HTTP_USER_ID'])
    if user_games.empty?
      render json: []
    else
      render json: { count: user_games.count }
    end
  end

  def count_users
    render json: { totalUsersCount: User.all.count }
  end

  def count_total_plays
    @games = Game.where(published: true)
    count = 0
    @games.each do |game|
      count += game.plays
    end
    render json: { totalGamePlays: count }
  end

  def count_total_articles
    count = Background.all.count + Obstacle.all.count + Entity.all.count
    render json: { totalArticlesCount: count }
  end

  def count_total_backgrounds
    render json: { totalBackgroundsCount: Background.all.count }
  end

  def count_total_obstacles
    render json: { totalObstacleCount: Obstacle.all.count }
  end

  def count_total_entities
    render json: { totalEntityCount: Entity.all.count }
  end

  def count_articles_by_game
    count = Background.where(game_id: params[:game_id]).count + Obstacle.where(game_id: params[:game_id]).count + Entity.where(game_id: params[:game_id]).count
    render json: { articlesByGameCount: count }
  end

  def count_backgrounds_by_game
    render json: { backgroundsByGameCount: Background.where(game_id: params[:game_id]).count }
  end

  def count_obstacles_by_game
    render json: { obstaclesByGameCount: Obstacle.where(game_id: params[:game_id]).count }
  end

  def count_entities_by_game
    render json: { entitiesByGameCount: Entity.where(game_id: params[:game_id]).count }
  end

  def savegame
    @savegame = SaveGame.new(
      game_id: params[:game_id],
      user_id: request.env['HTTP_USER_ID'],
      info: params[:info]
    )
    if @savegame.save
      render json: @savegame
    else
      render :json => { errors: @savegame.errors.full_messages }, status: 400
    end
  end

  # call this immediately after every load action
  def check_user_play
    @play = GamePlay.where('game_id = ? AND user_id = ?', params[:game_id], request.env['HTTP_USER_ID'])
    if @play.empty?
      render json: { message: 'need to add play' }
    else
      render json: { message: 'need to update play' }
    end
  end

  def add_user_play
    @play = GamePlay.add_game_play(@play, params, request.env['HTTP_USER_ID'])
    if @play.save
      render json: @play
    else
      render :json => { errors: @play.errors.full_messages }, status: 400
    end
  end

  def update_user_play
    @play = GamePlay.find_by('game_id = ? AND user_id = ?', params[:game_id], request.env['HTTP_USER_ID'])
    if @play.nil?
      render :json => { errors: @play.errors.full_messages }, status: 400
    else
      @play.increment!(:plays)#.plays += 1
      render json: @play
    end
  end

  def count_user_game_plays
    @play = GamePlay.find_by('game_id = ? AND user_id = ?', params[:game_id], request.env['HTTP_USER_ID'])
    if !@play.nil?
      render json: { userGamePlays: @play.plays }
    else
      render :json => { errors: @play.errors.full_messages }, status: 400
    end
  end

  def count_game_users
    count = GamePlay.where(game_id: params[:game_id]).count
    render json: { gameUsersCount: count }
  end

  def update_game_score
    @game = Game.find_by(game_id: params[:game_id])
    @game.score = params[:score]
    if @game.save
      render json: @game
    else
      render :json => { errors: @game.errors.full_messages }, status: 400
    end
  end
end
