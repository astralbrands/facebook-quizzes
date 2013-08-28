class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :quiz
  alias_method :original_answers, :answers

  def answer_from_category(category)
    answer = answers.find_or_create_by category: category
  end

  def answers
    original_answers.order "id asc"
  end

  def number
    Hash[self.quiz.questions.to_a.map.with_index.to_a][self] + 1  end
end
