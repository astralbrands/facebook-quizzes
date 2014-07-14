class Answer < ActiveRecord::Base
  belongs_to :category, autosave: false
  belongs_to :question, autosave: false
  validates :category, presence: true
  validates :question, presence: true
end
