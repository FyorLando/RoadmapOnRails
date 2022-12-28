module RatesModule
  class NodeRateController < ApplicationController
    before_action :authorize_request
    before_action :find_node_rate, except: %i[create index]

    def index
      @node_rates = NodeRate.all
      render json: @node_rates, status: :ok
    end

    def show
      render json: @node_rate, status: :ok
    end

    def create
      @node_rate = NodeRate.new(node_rate_params)
      if @node_rate.road_node.topic.created_user_id == @current_user.id or is_admin
        if @node_rate.save
          render json: @node_rate, status: :created
        else
          render json: { errors: @node_rate.errors.full_messages },
                 status: :unprocessable_entity
        end
      else
        render json: { errors: 'Permission Denied!' }, status: :unprocessable_entity
      end
    end

    def update
      if @node_rate.road_node.topic.created_user_id == @current_user.id or is_admin
        unless @node_rate.update(node_rate_upd_params)
          render json: { errors: @node_rate.errors.full_messages },
                 status: :unprocessable_entity
        end
        render json: @node_rate, status: :accepted
      else
        render json: { errors: 'Permission Denied!' }, status: :unprocessable_entity
      end
    end

    def destroy
      if @node_rate.road_node.topic.created_user_id == @current_user.id or is_admin
        if @node_rate.destroy
          render json: 'Successfully deleted', status: :accepted
        end
      else
        render json: { errors: 'Permission Denied!' }, status: :unprocessable_entity
      end
    end

    private

    def find_node_rate
      @node_rate = RatesModule::NodeRate.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'NodeRate not found' }, status: :not_found
    end

    def node_rate_params
      params.permit(
        :comment, :rate, :node_id
      )
    end

    def node_rate_upd_params
      params.permit(
        :comment, :rate
      )
    end
  end

end