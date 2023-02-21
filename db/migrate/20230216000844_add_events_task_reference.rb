class AddEventsTaskReference < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :task, foreign_key: true
  end
end
