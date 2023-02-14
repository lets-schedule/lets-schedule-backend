class CreateContraints < ActiveRecord::Migration[7.0]
  def change
    create_table :contraints do |t|
      t.datetime :dueTime
      t.datetime :duration

      t.timestamps
    end
  end
end
