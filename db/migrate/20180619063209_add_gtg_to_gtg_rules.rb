class AddGtgToGtgRules < ActiveRecord::Migration[5.2]
  def change
    add_reference :gtg_rules, :gtg, index: true, foreign_key: true
  end
end
