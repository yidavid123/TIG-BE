class CreateGtgRules < ActiveRecord::Migration[5.2]
  def change
    create_table :gtg_rules do |t|
      t.string :name
      t.integer :interval
      t.integer :penalty
      t.string :note

      t.timestamps
    end
  end
end
