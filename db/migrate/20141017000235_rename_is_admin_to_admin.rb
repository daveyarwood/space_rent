class RenameIsAdminToAdmin < ActiveRecord::Migration
  def up
    rename_column :people, :is_admin, :admin
  end
  
  def down
    rename_column :people, :admin, :is_admin
  end
end
