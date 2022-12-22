module UserModule
  class RoleController < ApplicationController
    before_action :authorize_request
    before_action :find_role, except: %i[create index]


    def index
      @roles = Role.all
      render json: @roles, status: :ok
    end


    def show
      render json: @role, status: :ok
    end


    def create
      @role = Role.new(role_params)
      if @role.save
        render json: @role, status: :created
      else
        render json: { errors: @role.errors.full_messages },
               status: :unprocessable_entity
      end
    end


    def update
      unless @role.update(role_params)
        render json: { errors: @role.errors.full_messages },
               status: :unprocessable_entity
      end
      render json: @role, status: :accepted
    end


    def destroy
      if @role.destroy
        render json: 'Successfully deleted', status: :accepted
      end
    end

    private

    def find_role
      @role = UserModule::Role.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Role not found' }, status: :not_found
    end

    def role_params
      params.permit(
        :title, :const
      )
    end

  end

end