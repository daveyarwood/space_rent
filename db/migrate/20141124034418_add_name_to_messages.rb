class AddNameToMessages < ActiveRecord::Migration
  def up
    add_column :messages, :name, :string
  end

  def down
    remove_column :messages, :name
  end
end
