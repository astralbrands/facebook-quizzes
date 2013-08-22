class CategoriesController < ApplicationController
  def create
    @quiz = Quiz.from_param params[:quiz_id]
    @category = @quiz.categories.create(category_params)
    @category.display_img = params[:category][:display_img]
    @category.share_img = params[:category][:share_img]
    redirect_to edit_quiz_path(@quiz)
  end

  def destroy
    @category = Category.find params[:id]
    @category.answers.destroy
    @category.destroy
    redirect_to edit_quiz_path(@category.quiz)
  end

  def update
    @category = Category.find params[:id]
    @category.update category_params
    redirect_to edit_quiz_path(@category.quiz)
  end

  private
    def category_params
      params.require(:category).permit(:title, :text, :display_img, :share_img)
    end
end
