class Category < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :quiz

  validates_each :answers, on: :update do |record, attr, value|
    record.quiz.questions.collect{|question| question.has_answer?(record)}.all?{|i| i == true }
  end

  after_create do
    self.slug = title.parameterize
    self.text = "" if self.text.nil?
    quiz.questions.each do |question|
      question.create_answer(self)
    end
  end


end
