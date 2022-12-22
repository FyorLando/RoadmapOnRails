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
      if User.exists?(id: user_f_params[:user_id])
        @user_f = UserFavourite.new(user_f_params)
      else
        render json: { errors: "incorrect user_id" },
               status: :unprocessable_entity
        return
      end
      if RoadmapsModule::Topic.exists?(id: user_f_params[:topic_id])
        @user_r = UserFavourite.new(user_f_params)
      else
        render json: { errors: "incorrect topic_id" },
               status: :unprocessable_entity
        return
      end
      if @user_f.save
        render json: @user_f, status: :created
      else
        render json: { errors: @user_f.errors.full_messages },
               status: :unprocessable_entity
      end
    end



    def update
      unless User.exists?(id: user_f_params[:user_id])
        render json: { errors: "incorrect user_id" },
               status: :unprocessable_entity
        return
      end
      unless RoadmapsModule::Topic.exists?(id: user_f_params[:topic_id])
        render json: { errors: "incorrect topic_id" },
               status: :unprocessable_entity
        return
      end
      unless @user_f.update(user_f_params)
        render json: { errors: @user_f.errors.full_messages },
               status: :unprocessable_entity
      end
      render json: @user_f, status: :accepted
    end


    def destroy
      if @user_f.destroy
        render json: 'Successfully deleted', status: :accepted
      end
    end

    private

    def find_user_f
      @user_f = UserFavourite.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'UserFavourite not found' }, status: :not_found
    end

    def user_f_params
      params.permit(
        :user_id, :topic_id
      )
    end

  end
end
