class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.person :person
      t.string :text

      t.timestamps
    end
  end
end
