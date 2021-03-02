class AddAttendeeIdToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :attendee_id, :integer
  end
end
