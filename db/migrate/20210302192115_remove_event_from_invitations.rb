class RemoveEventFromInvitations < ActiveRecord::Migration[6.0]
  def change
    remove_reference :invitations, :event, null: false, foreign_key: true
  end
end
