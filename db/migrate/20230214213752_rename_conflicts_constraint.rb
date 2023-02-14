class RenameConflictsConstraint < ActiveRecord::Migration[7.0]
  def change
    rename_table :conflicts, :constraints
  end
end
