class AddDefaultToBill < ActiveRecord::Migration
  def change
    change_column :bills, :late, :boolean, default: false
  end
end
