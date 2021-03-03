class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]
  def index
    @events = Event.all.order("created_at DESC") 
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event 
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event 
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:creator_id,
                                  :title, 
                                  :description, 
                                  :location, 
                                  :start_date, 
                                  :end_date, 
                                  :start_time, 
                                  :end_time)
  end

end
