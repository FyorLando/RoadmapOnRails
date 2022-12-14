module UserModule
  class UserController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_user, except: %i[create index me]


    def index
      @users = User.all
      render json: @users, status: :ok
    end


    def show
      render json: @user, status: :ok
    end

    def me
      render json: @current_user, status: :ok
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end


    def update
      unless @user.update(user_params)
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
      render json: @user, status: :accepted
    end


    def destroy
      if @user.destroy
        render json: 'Successfully deleted', status: :accepted
      end
    end

    private

    def find_user
      @user = UserModule::User.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
      params.permit(
        :email, :password, :password_confirmation, :role_id
      )
    end

  end

end