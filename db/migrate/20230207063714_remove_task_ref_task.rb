class RemoveTaskRefTask < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tasks, :task, foreign_key: true, index: false
  end
end
