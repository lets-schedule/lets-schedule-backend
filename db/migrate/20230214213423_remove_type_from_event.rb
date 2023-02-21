class RemoveTypeFromEvent < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :type, :boolean
  end
end
