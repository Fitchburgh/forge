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

  def update_requested_status
    @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', params[:game_id], request.env['HTTP_USER_ID'])
    if !@collaborator.nil?
      Collaborator.flip_requested_value(@collaborator)
      @collaborator.save!
      render json: @collaborator
    else
      render :json => { errors: @collaborators.errors.full_messages }, status: 400
    end
  end

  def make_collaborator
    @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', params[:game_id], request.env['HTTP_USER_ID'])
    if !@collaborator.nil?
      Collaborator.flip_accepted_value(@collaborator)
      @collaborator.save!
      render json: @collaborator
    else
      render :json => { errors: @collaborators.errors.full_messages }, status: 400
    end
  end

  def find_game_requesters_and_collaborators
    @collaborators = Collaborator.where('game_id = ? AND requested = ?', params[:game_id], true)
    if !@collaborators.empty?
      render json: @collaborators
    else
      render :json => { errors: @collaborators.errors.full_messages }, status: 400
    end
  end

  def find_game_requesters
    @collaborators = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', params[:game_id], true, false)
    if !@collaborators.empty?
      render json: @collaborators
    else
      render :json => { errors: @collaborators.errors.full_messages }, status: 400
    end
  end

  def find_game_collaborators
    @collaborators = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', params[:game_id], true, true)
    if !@collaborators.empty?
      render json: @collaborators
    else
      render :json => { errors: @collaborators.errors.full_messages }, status: 400
    end
  end

  def find_user_collaborators
    ids = Game.find_game_ids_by_creator(@games, params)
    collaborators = []
    ids.each do |id|
      @collaborators = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', id, true, true)
      collaborators << @collaborators
    end
    render json: collaborators[0]
  end

  def find_user_requesters
    ids = Game.find_game_ids_by_creator(@games, params)
    requesters = []
    ids.each do |id|
      @requesters = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', id, true, false)
      requesters << @requesters
    end
    render json: requesters[0]
  end
end
