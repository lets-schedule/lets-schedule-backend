class RemoveEventTaskReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :events, :tasks, foreign_key: true
  end
end
