class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    # @recipe = Recipe.find(params[:id])
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
  
  private
  
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
  
    def recipe_params
      params.require(:recipe).permit(:name, :description, :chef_id)
    end
    
    def require_same_user
      if current_chef != @recipe.chef
        flash[:danger] = "You can only edit or delete your own recipes."
        redirect_to recipes_path
      end
    end
end
