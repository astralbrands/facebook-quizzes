class Category < ActiveRecord::Base
  has_attached_file :display_img, styles: { standard: "500x300" }, default_url: "/images/:style/missing.png"
  has_attached_file :share_img, styles: { standard: "500x300" }, default_url: "/images/:style/missing.png"
  has_many :answers
  belongs_to :quiz
end
