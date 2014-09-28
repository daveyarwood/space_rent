class RenameLogMessageToIsLogMessage < ActiveRecord::Migration
  def up
    rename_column :messages, :log_message, :is_log_message
  end
  
  def down
    rename_column :messages, :is_log_message, :log_message
  end
end
