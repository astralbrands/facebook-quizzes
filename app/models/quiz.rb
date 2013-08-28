class Quiz < ActiveRecord::Base
  has_attached_file :banner, styles: { standard: "500x300" }, default_url: "/artwork/quiz-banner.jpg"
  has_attached_file :product_img, styles: { standard: "150x100" }, default_url: "/artwork/quiz-product.jpg"
  has_many :questions
  has_many :categories
  validates :name, presence: true
  validates :intro, presence: true
  alias_method :original_questions, :questions
  alias_method :original_categories, :categories

  def to_param
    "#{name.parameterize}"
  end

  def self.from_param(param)
    find_by slug: param
  end

  def last?(question)
    questions.index(question) + 1 == questions.size
  end

  def questions
    original_questions.order "id asc"
  end

  def banner_url
    "/artwork/#{id}/banner.jpg"
  end

  def product_img_url
    "/artwork/#{id}/product.jpg"
  end

  def categories
    original_categories.order "id asc"
  end

  def get_results(answers)
    results = {}
    categories.each {|c| results[c.id] = 0 }
    answers.each {|k, v| results[v] += Question.find(k.gsub(/question_/, '').to_i).weight }
    most_responded_category = results.max_by{|k, v| v }.first
    return categories.find most_responded_category
  end
end
