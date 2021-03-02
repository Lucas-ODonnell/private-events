class RemoveCreatorFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_reference :events, :creator, null: false, foreign_key: true
  end
end
