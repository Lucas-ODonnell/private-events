class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]
  def index
    @events = Event.all.order("created_at DESC") 
  end

  def show
    @event = Event.find_by(id: params[:id])
    @invitations = @event.invitations.includes([:attendee]).sort_by(&:status)
  end

  def new
    @event = Event.new
    @event.invitations.build
    @attendee_options = possible_attendees
  end

  def create
    @event = current_user.created_events.build(event_params)
    @invitation = Invitation.new
    if @event.save
      InvitationManager.new(@event, invitation_params).create_invitations
      redirect_to @event 
    else
      @attendees = invitation_params[:invitations][:attendee_id]
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    @attendee_options = possible_attendees
    @attendees = @event.attendee_ids
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      InvitationManager.new(@event, invitation_params).update_invitations
      redirect_to @event 
    else
      @attendee_options = possible_attendees
      @attendees = invitation_params[:invitations][:attendee_id]
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

  def invitation_params
    params.require(:event).permit(invitations: [attendee_id:[]])
  end

  def possible_attendees
    User.all.reject { |user| user == current_user }
  end
end
