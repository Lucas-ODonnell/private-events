class InvitationManager
  def initialize(event, params)
    @event = event
    @attendee_ids = params[:invitations][:attendee_id]
  end

  def create_invitations
    @attendee_ids.each do |id|
      if @event.attendees.ids.include?(id.to_i)
        next
      else
        @event.invitations.create(attendee_id: id)
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
