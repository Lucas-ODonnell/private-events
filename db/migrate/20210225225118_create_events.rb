class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :creator, null: false, foreign_key: true
      t.string :title, limit: 7, null: false
      t.text :description, null: false
      t.string :location, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.timestamps
    end
  end
end
