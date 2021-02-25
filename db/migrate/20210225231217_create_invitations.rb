class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.references :attendee, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
