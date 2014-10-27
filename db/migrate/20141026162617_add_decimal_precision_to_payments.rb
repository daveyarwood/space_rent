class AddDecimalPrecisionToPayments < ActiveRecord::Migration
  def up
    change_column :payments, :amount, :decimal, precision: 10, scale: 2
  end
  
  def down
    change_column :payments, :amount, :decimal
  end
end
