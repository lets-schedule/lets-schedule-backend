class AddConstraintTaskRef < ActiveRecord::Migration[7.0]
  def change
    add_reference :constraints, :task, foreign_key: true
  end
end
