class AddSlugToCategory < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.string :slug
    end
  end
end
