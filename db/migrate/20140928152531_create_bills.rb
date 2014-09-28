class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.decimal :owed
      t.boolean :late

      t.timestamps
    end
  end
end
