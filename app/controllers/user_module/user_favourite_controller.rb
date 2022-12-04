module UserModule
  class UserFavouriteController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_user_f, except: %i[create index]

    def index
      @users = UserFavourite.all
      render json: @users, status: :ok
    end


    def show
      render json: @user_f, status: :ok
    end



    private

    def find_user_f
      @user_f = UserFavourite.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
    end



  end
end
