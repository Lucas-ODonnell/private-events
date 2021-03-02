class RemoveAttendeeFromInvitations < ActiveRecord::Migration[6.0]
  def change
    remove_reference :invitations, :attendee, null: false, foreign_key: true
  end
end
