class CreateMeetings < ActiveRecord::Migration[5.0]
  def change
    create_table :meetings do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_time

      t.timestamps
    end
  end
end
