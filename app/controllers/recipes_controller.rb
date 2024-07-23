class RecipesController < ApplicationController

  # GET /recipes
  def index
    user = find_user
    if user
      recipes = Recipe.all
      render json: recipes, status: :created
    else
      render json: { errors: ["You must be logged in."] }, status: :unauthorized
    end
  end

  # GET /recipes/1
  # def show
  #   render json: recipe
  # end

  # POST /recipes
  def create
    user = find_user
    if user
      recipe = user.recipes.create(recipe_params)
      if recipe.valid?
        render json: recipe, status: :created
      else
        render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ["You must be logged in."] }, status: :unauthorized
    end
  end

  # PATCH/PUT /recipes/1
  # def update
  #   recipe = find_recipe
  #   if recipe
  #     recipe.update(recipe_params)
  #     render json: recipe, status: :created
  #   else
  #     render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /recipes/1
  # def destroy
  #   recipe = find_recipe
  #   if recipe
  #     recipe.destroy
  #     head :no_content
  #   else
  #     render json: { errors: ["Recipe does not exist."] }, status: :not_found
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_user
      User.find_by(id: session[:user_id])
    end

    def find_recipe
      Recipe.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:title, :instructions, :minutes_to_complete)
    rescue ActionController::ParameterMissing
      params.permit(:title, :instructions, :minutes_to_complete)
    end
end
  