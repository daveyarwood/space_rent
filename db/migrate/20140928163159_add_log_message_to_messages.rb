class AddLogMessageToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :log_message, :boolean, default: false
  end
end
