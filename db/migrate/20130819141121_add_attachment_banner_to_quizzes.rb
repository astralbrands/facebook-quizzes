class AddAttachmentBannerToQuizzes < ActiveRecord::Migration
  def self.up
    change_table :quizzes do |t|
      t.attachment :banner
    end
  end

  def self.down
    drop_attached_file :quizzes, :banner
  end
end
