class EventsController < ApplicationController
  def index
    render :json => Event.all
  end

  def create
    @event = Event.create_event_article(@event, params, request.env['HTTP_USER_ID'])
    if @event.save
      render json: @event, status: 201
    else
      render :json => { errors: @event.errors.full_messages }, status: 400
    end
  end

  def update
    @event = Event.find_by(id: params[:id])
    if !@event.nil?
      Event.update_event(@event, params, request.env['HTTP_USER_ID'])
      if @event.save
        render json: @event
      else
        render :json => { errors: @event.errors.full_messages }, status: 404
      end
    else
      render :json => { message: 'event is not found' }, status: 400
    end
  end

  def delete
    @event = Event.find_by(id: params[:id])
    if @event.nil?
      render :json => { error: 'event not detected' }, status: 404
    else
      render :json => { message: 'event deleted' } if @event.delete
    end
  end

  def search
    @events = Event.find_event_by_input(@events, params[:name])
    render json: @events
  end
end
