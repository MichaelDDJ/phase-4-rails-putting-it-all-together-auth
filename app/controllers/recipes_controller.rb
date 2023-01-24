class RecipesController < ApplicationController

    wrap_parameters format:[]
    def index
        user = User.find_by(id: session[:user_id])
        if user
            recipes = Recipe.all
            render json: recipes, include: :user, status: :created
        else
            render json: {errors: ["Not authorized"]}, status: :unauthorized
        end
    end

    def create
        user = User.find_by(id: session[:user_id])
        if user
            recipe = Recipe.create(recipe_params)
            user.recipes << recipe
            if recipe.valid? 
                render json: recipe, include: :user, status: :created
            else
                render json: {errors: [recipe.errors] }, status: :unprocessable_entity
            end
        else
            render json: {errors: ["Not authorized"]}, status: :unauthorized
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
