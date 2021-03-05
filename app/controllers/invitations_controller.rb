class InvitationsController < ApplicationController
  before_action :authenticate_user!, only: [:edit_all, :update_all]

  def edit_all
    @invitations = possible_invitations
    @status_options = possible_statuses
  end

  def update_all
    @invitations = Invitation.update(params[:invitations].keys, params[:invitations].values)
    @invitations.reject! { |invite| invite.errors.empty? }
    if @invitations.empty?
      redirect_to edit_all_invitations_path
    else
      render "edit_all"
    end
  end

  private

  def possible_statuses
    Invitation.statuses.map { |k, _v| [k.capitalize, k] }
  end

  def invitation_params
    params.require(:invitation).permit(:status)
  end

  def possible_invitations
    Invitation.all.includes([event: [:creator]]).select do |invite|
      invite.attendee_id == current_user.id && invite.event.start_date >= Time.now
    end
  end
end
