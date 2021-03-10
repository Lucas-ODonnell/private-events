class InvitationManager
  def initialize(event, params)
    @event = event
    @attendee_ids = params[:invitations][:attendee_id]
  end

  def create_invitations
    #This relates to the event_controller
    #InvitationManager.new(@event, invitation_params).create_invitations
    attendees = @event.attendees
    @attendee_ids.each do |id|
      if attendees.ids.include?(id.to_i)
        next
      else
        Invitation.create(attendee_id: id, event_id: @event.id)
      end
    end
  end

  def update_invitations
    create_invitations
    destroy_invitations
  end

  def destroy_invitations
    @event.attendees.ids.each do |id|
      if @attendee_ids.include?(id.to_s)
        next
      else
        invitation = @event.invitations.where(attendee_id: id)
        @event.invitations.destroy(invitation)
      end
    end
  end
end
