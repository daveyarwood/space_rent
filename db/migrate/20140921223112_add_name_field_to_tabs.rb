class AddNameFieldToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :name, :string
  end
end
