class Quiz < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :categories, dependent: :destroy
  validates :name, presence: true
  validates :slug, presence: true
  alias_method :original_questions, :questions
  alias_method :original_categories, :categories

  before_validation do
    self.slug = name.parameterize
  end

  def to_param
    "#{name.parameterize}"
  end

  def self.from_yaml(name)
    file_name = "./db/copy/#{name}.yaml"
    object = YAML.load(IO.read(file_name))
    quiz = Quiz.find_or_create_by(name: name)
    quiz.destroy
    quiz = Quiz.find_or_create_by(name: name)
    object["categories"].each do |category|
      name = category[0]
      call_out = category[1]["call_out"]
      blurb = category[1]["blurb"]
      link_text = category[1]["link"]["text"]
      link_href = category[1]["link"]["href"]
      Category.find_or_create_by(title: name,
                                 text: blurb,
                                 quiz: quiz,
                                 statement: call_out)
    end
    object["questions"].each do |question|
      q = Question.find_or_create_by(quiz: quiz,
                                     text: question["question"])
      question["answers"].each_with_index do |answer, index|
        a = Answer.find_by(category: Category.find_by(quiz: quiz, title: answer[0]),
                           question: q)
        a.update(content: answer[1], sequence: index.+(1))
      end
    end
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

  def categories
    original_categories.order "id asc"
  end

  def get_results(answers)
    results = {}
    categories.each {|c| results[c.id] = 0 }
    answers.each do |k, v|
      question = questions.find{|q| q.id == k.gsub(/question_/, '').to_i }
      answer = question.answers.find{|a| a.category_id == v }
      weight = question.weight || 1
      category = answer.category
      results[category.id] += weight
    end
    most_responded_category = results.max_by{|k, v| v }.first
    return categories.find most_responded_category
  end
end
