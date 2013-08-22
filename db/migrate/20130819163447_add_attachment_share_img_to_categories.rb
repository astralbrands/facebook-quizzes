class AddAttachmentShareImgToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.attachment :share_img
    end
  end

  def self.down
    drop_attached_file :categories, :share_img
  end
end
