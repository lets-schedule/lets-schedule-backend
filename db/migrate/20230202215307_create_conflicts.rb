class CreateConflicts < ActiveRecord::Migration[7.0]
  def change
    create_table :conflicts do |t|
      t.integer :duration
      t.datetime :due_time

      t.timestamps
    end
  end
end
