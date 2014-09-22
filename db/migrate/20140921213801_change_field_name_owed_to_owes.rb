class ChangeFieldNameOwedToOwes < ActiveRecord::Migration
  def change
    rename_column :people, :owed, :owes
  end
end
