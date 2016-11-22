class CollaboratorsController < ApplicationController
  def check_collab_existence
    @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', params[:game_id], request.env['HTTP_USER_ID'])
    if @collaborator.nil?
      render :json => { message: 'this user has not requested to be a collaborator for this game' }
    else
      render json: @collaborator
    end
  end

  def create
    @collaborator = Collaborator.create_new_collaborator(@collaborator, params, request.env['HTTP_USER_ID'])
    if @collaborator.save
      render json: @collaborator
    else
      render :json => { :errors => @collaborator.errors.full_messages }, status: 400
    end
  end

  def make_user_collaborator_for_own_game
    @collaborator = Collaborator.make_user_collaborator(@collaborator, params, request.env['HTTP_USER_ID'])
    if @collaborator.save
      render json: @collaborator
    else
      render :json => { :errors => @collaborator.errors.full_messages }, status: 400
    end
  end

  def update_requested_status
    @game = Game.find(params[:game_id])
    if @game.user_id == request.env['HTTP_USER_ID'].to_i
      @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', params[:game_id], params[:requester_id])
      if !@collaborator.nil?
        Collaborator.flip_requested_value(@collaborator)
        @collaborator.save!
        render json: @collaborator
      else
        render :json => { errors: @collaborators.errors.full_messages }, status: 400
      end
    else
      render :json => { message: 'only the game\'s creator can update this status' }, status: 400
    end
  end

  def make_collaborator
    @game = Game.find(params[:game_id])
    if @game.user_id == request.env['HTTP_USER_ID'].to_i
      @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', params[:game_id], params[:requester_id])
      if !@collaborator.nil?
        Collaborator.flip_accepted_value(@collaborator)
        @collaborator.save!
        render json: @collaborator
      else
        render :json => { errors: @collaborators.errors.full_messages }, status: 400
      end
    else
      render :json => { message: 'only the game\'s creator can update this status' }, status: 400
    end
  end

  def find_game_requesters_and_collaborators
    @collaborators = Collaborator.where('game_id = ? AND requested = ?', params[:game_id], true)
    if !@collaborators.empty?
      render json: @collaborators
    else
      render :json => { message: 'no requesters or collaborators for this game' }, status: 400
    end
  end

  def find_game_requesters
    @collaborators = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', params[:game_id], true, false)
    if !@collaborators.empty?
      render json: @collaborators
    else
      render :json => { message: 'no requesters for this game' }, status: 400
    end
  end

  def find_game_collaborators
    @collaborators = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', params[:game_id], true, true)
    if !@collaborators.empty?
      render json: @collaborators
    else
      render :json => { message: 'no collaborators for this game' }, status: 400
    end
  end

  def find_user_collaborators
    ids = Game.find_game_ids_by_creator(@games, request.env['HTTP_USER_ID'])
    collaborators = Collaborator.find_collaborators_by_game(@collaborators, ids)
    user_collaborators = User.find_username_for_collaborators(collaborators)
    render json: user_collaborators
  end

  def find_user_requesters
    ids = Game.find_game_ids_by_creator(@games, request.env['HTTP_USER_ID'])
    requesters = Collaborator.find_requesters_by_game(@requesters, ids)
    user_requesters = User.find_username_for_requesters(requesters)
    render json: user_requesters
  end

  def find_collaborations_by_user
    game_ids = Collaborator.find_collaborations_by_user(request.env['HTTP_USER_ID'])
    games = Game.find_game_ids(game_ids, request.env['HTTP_USER_ID'])
    users = User.find_username_by_game_creator_id(games)
    result = Collaborator.return_user_collaborations(games, users)
    render json: result
  end
end
