module UserModule
  class UserFavouriteController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_user_f, except: %i[create index]

    def index
      @users_f = UserFavourite.all
      render json: @users_f, status: :ok
    end


    def show
      render json: @user_f, status: :ok
    end

    def create
      @user = User.find_by_id(user_f_params[:user_id])
      #TODO topic_id check
      if @user
        @user_f = UserFavourite.new(user_f_params)
      end
      if @user_f.save
        render json: @user_f, status: :created
      else
        render json: { errors: @user_f.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    private

    def find_user_f
      @user_f = UserFavourite.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
    end

    def user_f_params
      params.permit(
        :user_id#, :topic_id
      )
    end

  end
end
