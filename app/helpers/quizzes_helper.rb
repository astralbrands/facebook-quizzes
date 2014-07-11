module QuizzesHelper
  def slug
    @quiz.slug.underscore
  end
end