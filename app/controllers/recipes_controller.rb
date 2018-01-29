class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :like]
  before_action :require_user, except: [:index, :show, :like]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end

  def show
    # @recipe = Recipe.find(params[:id])
    @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
    @comment = Comment.new # init new user comment if user submits one
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
    # if !@recipe.chef_id.present?
    #   @recipe.chef_id = 1
    # end
    if @recipe.save
      flash[:success] = "Recipe was successfully created."
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def edit
    # @recipe = Recipe.find(params[:id])
  end

  def update
    # @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was updated successfully"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    # @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:success] = "Recipe deleted successfully"
      redirect_to recipes_path
    else
      flash[:warning] = "Sorry, there was an error. Please try again."
      redirect_to recipe_path(@recipe)
    end
  end

  def like
    require_user_like
    like = Like.create(like: params[:like], chef: current_chef, recipe: @recipe)
    if like.valid? # what is this 'valid?' function
      flash[:success] = "Your preference has been recorded"
      redirect_back(fallback_location: root_path) ### <-- See how to make it seem like the page hasn't changed
    else
      flash[:danger] = "You can only like or dislike a recipe once"
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:name, :description, :chef_id, ingredient_ids: [])
    end

    def require_same_user
      if current_chef != @recipe.chef && !current_chef.admin?
        flash[:danger] = "You can only edit or delete your own recipes."
        redirect_to recipes_path
      end
    end

    def require_user_like
      if !logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_back(fallback_location: root_path)
      end
    end
end
