class AddProductCopyToQuizzes < ActiveRecord::Migration
  def change
    change_table :quizzes do |t|
      t.text :product_copy
    end
  end
end
