class ChangeMessagePersonToPersonId < ActiveRecord::Migration
  def change
    rename_column :messages, :person, :person_id
  end
end
