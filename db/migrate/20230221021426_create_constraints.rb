class CreateConstraints < ActiveRecord::Migration[7.0]
  def change
    create_table :constraints do |t|
      t.datetime :dueTime
      t.integer :duration

      t.timestamps
    end
  end
end
