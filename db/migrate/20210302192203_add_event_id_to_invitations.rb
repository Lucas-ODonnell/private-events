class AddEventIdToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :event_id, :integer
  end
end
