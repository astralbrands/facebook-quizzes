class Category < ActiveRecord::Base
  has_many :answers
  belongs_to :quiz

  before_validation do
    self.slug = title.parameterize
    self.text = "" if self.text.nil?
  end
end
