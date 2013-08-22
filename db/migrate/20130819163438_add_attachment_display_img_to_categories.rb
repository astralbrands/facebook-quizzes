class AddAttachmentDisplayImgToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.attachment :display_img
    end
  end

  def self.down
    drop_attached_file :categories, :display_img
  end
end
