class CreateGtgs < ActiveRecord::Migration[5.2]
  def change
    create_table :gtgs do |t|
      t.string :name
      t.string :location
      t.timestamp :time
      t.string :owner

      t.timestamps
    end
  end
end
