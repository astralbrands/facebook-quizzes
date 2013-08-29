class ChangeOrderColumnsToSequence < ActiveRecord::Migration
  def change
      rename_column :questions, :order, :sequence
      rename_column :answers, :order, :sequence
  end
end
