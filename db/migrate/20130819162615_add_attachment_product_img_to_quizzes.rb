class AddAttachmentProductImgToQuizzes < ActiveRecord::Migration
  def self.up
    change_table :quizzes do |t|
      t.attachment :product_img
    end
  end

  def self.down
    drop_attached_file :quizzes, :product_img
  end
end
