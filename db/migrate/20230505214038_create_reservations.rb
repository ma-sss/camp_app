class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date "day", null: false
      t.bigint "admin_id", null: false
      t.bigint "user_id", null: false
      t.datetime "start_time", null: false
      t.timestamps
    end
  end
end
