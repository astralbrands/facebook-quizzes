class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :quiz
  validates :quiz_id, presence: true
  validates :sequence, presence: true
  alias_method :original_answers, :answers

  before_validation do
    self.sequence = quiz.questions.length + 1
  end

  def answer_from_category(category)
    answer = answers.find_or_create_by category: category
  end

  def answers
    original_answers.order "sequence asc"
  end

  def number
    Hash[self.quiz.questions.to_a.map.with_index.to_a][self] + 1
  end

  def create_answer(category)
    unless has_answer?(category)
      answer = Answer.new(category: category, question: self)
      answer.save
    end
  end

  def has_answer?(category)
    !answers.where(category: category).empty?
  end

  def make_answers
    quiz.categories.each{|category| create_answer(category)}
  end

  after_create do
    make_answers
  end
end
