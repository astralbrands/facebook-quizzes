class Category < ActiveRecord::Base
  has_attached_file :display_img, styles: { standard: "500x300" }, default_url: "/images/:style/missing.png"
  has_attached_file :share_img, styles: { standard: "500x300" }, default_url: "/images/:style/missing.png"
  has_many :answers
  belongs_to :quiz

  before_validation do
    self.slug = title.parameterize
  end 

  def display_img_url
    "/artwork/#{quiz.id}/display/#{title.parameterize}.jpg"
  end

  def share_img_url
    "/artwork/#{quiz.id}/share/#{title.parameterize}.jpg"
  end
end
