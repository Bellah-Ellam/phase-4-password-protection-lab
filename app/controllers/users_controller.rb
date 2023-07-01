class UsersController < ApplicationController
    before_action :authenticate_user, only: [:show]

    def show
        user = User.find(session[:user_id])
        render json: user
    end


    def create
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
      

    def authenticate_user
        unless session[:user_id]
          render json: { error: "Unauthorized" }, status: :unauthorized
        end
    end
  end