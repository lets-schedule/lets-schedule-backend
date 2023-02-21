class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.datetime :start_date_time
      t.datetime :end_date_time

      t.timestamps
    end
  end
end
