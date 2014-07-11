class AddStatementToCategory < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.text :statement
    end
  end
end
