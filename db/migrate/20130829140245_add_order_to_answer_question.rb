class AddOrderToAnswerQuestion < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.integer :order
    end

    change_table :answers do |t|
      t.integer :order
    end
  end
end
