class Quiz < ActiveRecord::Base
  has_attached_file :banner, styles: { standard: "500x300" }, default_url: "/images/:style/missing.png"
  has_attached_file :product_img, styles: { standard: "150x100" }, default_url: "/images/:style/missing.png"
  has_many :questions
  has_many :categories
  validates :name, presence: true
  validates :intro, presence: true

  def to_param
    "#{name.parameterize}"
  end

  def self.from_param(param)
    find_by slug: param
  end

  def last?(question)
    question.id == questions.size
  end

  def get_results(answers)
    results = {}
    categories.each {|c| results[c.id] = answers.values.count(c.id) }
    most_responded_category = results.max_by{|k, v| v }.first
    return categories.find most_responded_category
  end
end
