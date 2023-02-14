class AddReferenceConstraintTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :constraints, foreign_key: true
  end
end
