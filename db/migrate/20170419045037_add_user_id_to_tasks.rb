class AddUserIdToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :user_id, :int
  end
end
