class ChangeDecimalPrecision < ActiveRecord::Migration
  def change
    change_column :people, :owes, :decimal, :precision => 10, :scale => 2
    change_column :tabs, :amount, :decimal, :precision => 10, :scale => 2
  end
end
