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
    questions.max_by{|q| q.sequence } == question
  end

  def questions
    original_questions.order "sequence asc"
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
    answers.each do |k, v|
      question = Question.find{|q| q.sequence == k.gsub(/question_/, '').to_i}
      answer = question.answers.find{|a| a.sequence == v }
      weight = question.weight
      category = answer.category
      x = {question: question, answer: answer, weight: weight, category: category}
      results[category.id] += weight
    end
    most_responded_category = results.max_by{|k, v| v }.first
    return categories.find most_responded_category
  end
end
