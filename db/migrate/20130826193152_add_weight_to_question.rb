class AddWeightToQuestion < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.integer "weight"
    end
  end
end
