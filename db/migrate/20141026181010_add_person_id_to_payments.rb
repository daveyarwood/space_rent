class AddPersonIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :person_id, :string
  end
end
