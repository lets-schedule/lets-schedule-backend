class AddTaskEventKey < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :tasks, foreign_key: true
  end
end
