class Answer < ActiveRecord::Base
  belongs_to :category
  belongs_to :question
  validates :category, presence: true
  validates :question, presence: true
end
