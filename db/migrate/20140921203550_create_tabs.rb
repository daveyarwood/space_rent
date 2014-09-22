class CreateTabs < ActiveRecord::Migration
  def change
    create_table :tabs do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
