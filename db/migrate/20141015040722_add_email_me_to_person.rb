class AddEmailMeToPerson < ActiveRecord::Migration
  def change
    add_column :people, :email_me, :boolean, default: true
  end
end
