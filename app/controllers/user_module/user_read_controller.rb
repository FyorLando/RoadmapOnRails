module UserModule
  class UserReadController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_user_r, except: %i[create index]

    def index
      @user_r = UserRead.includes(:topic)
      @user_r = @user_r.filter_by_user_id(user_r_params[:user_id]) if params[:user_id].present?
      render json: @user_r.to_json( :include => [:topic], :except => [:topic_id]), status: :ok
    end

    def show
      render json: @user_r, status: :ok
    end

    def create
      if User.exists?(id: user_r_params[:user_id])
        @user_r = UserRead.new(user_r_params)
      else
        render json: { errors: "incorrect user_id" },
               status: :unprocessable_entity
        return
      end
      if RoadmapsModule::Topic.exists?(id: user_r_params[:topic_id])
        @user_r = UserRead.new(user_r_params)
      else
        render json: { errors: "incorrect topic_id" },
               status: :unprocessable_entity
        return
      end
      if @user_r.save
        render json: @user_r, status: :created
      else
        render json: { errors: @user_r.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def update
      unless User.exists?(id: user_r_params[:user_id])
        render json: { errors: "incorrect user_id" },
               status: :unprocessable_entity
        return
      end
      unless RoadmapsModule::Topic.exists?(id: user_r_params[:topic_id])
        render json: { errors: "incorrect topic_id" },
               status: :unprocessable_entity
        return
      end
      unless @user_r.update(user_r_params)
        render json: { errors: @user_r.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def destroy
      if @user_r.destroy
        render json: 'Successfully deleted', status: :accepted
      end
    end

    private

    def find_user_r
      @user_r = UserRead.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'UserRead not found' }, status: :not_found
    end

    def user_r_params
      params.permit(
        :user_id, :topic_id
      )
    end

  end
end
