class UsersController < ApplicationController
  def current_user
    @user = User.find(request.env['HTTP_USER_ID'])
  end

  def update_current_play
    current_user
    game = params[:game_id]
    @user[:playing_game] = game
    if @user.save
      render json: 'User updated'
    else
      render :json => { errors: @user.errors.full_messages }, status: 400
    end
  end

  def update_current_edit
    game = params[:game_id]
    current_user
    @user.editing_game = game
    if @user.save
      render json: 'User updated'
    else
      render :json => { errors: @user.errors.full_messages }, status: 400
    end
  end

  def current_play
    current_user
    find_current_game_send_response(@user.playing_game)
  end

  def current_edit
    current_user
    find_current_game_send_response(@user.editing_game)
  end

  def find_current_game_send_response(adjustment)
    @game = Game.find_by(id: adjustment)
    render json: @game.errors.full_messages if @game.nil?
    render json: @game
  end

  def current_username
    render json: @user.username if current_user
  end

  def update
    @user = User.find(request.env['HTTP_USER_ID'])
    @user.username = params[:username]
    @user.save!
    render json: @user
  end
end
