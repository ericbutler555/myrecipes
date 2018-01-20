class CommentsController < ApplicationController

  before_action :require_user # make sure only logged-in users can get here (method is defined in application_controller).

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.chef = current_chef
    if @comment.save
      flash[:success] = "Comment has been saved"
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "Comment was not saved"
      redirect_to :back
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:description)
    end

end
