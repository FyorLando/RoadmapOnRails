module RoadmapsModule
  class RoadNodeController < ApplicationController
    before_action :authorize_request, only: [:create, :update, :destroy]
    before_action :find_roadnode, except: [:create, :index]

    def index
      @nodes = RoadNode.all
      render json: @nodes, status: :ok
    end

    def show
      render json: @node, status: :ok
    end

    def create
      @node = road_node_params.to_hash
      if Topic.find_by_id(@node[:topic_id]).created_user_id == @current_user.id
        if RoadNodeHelper.save_tree(@node)
          render json: @node, status: :created
        else
          render json: { status: "Not Saved!" },
                 status: :unprocessable_entity
        end
      end
    end

    def update
      if @node.topic.created_user_id == @current_user.id
        unless @node.update(road_node_params)
          render json: { errors: @node.errors.full_messages },
                 status: :unprocessable_entity
        end
        render json: @node, status: :accepted
      end
    end

    def destroy
      if @node.topic.created_user_id != @current_user.id
        if @node.destroy
          render json: 'Successfully deleted', status: :accepted
        end
      end
    end

    private

    def find_roadnode
      @node = RoadNode.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'RoadNode not found' }, status: :not_found
    end

    def road_node_params
      params.permit(
        :title, :description, :topic_id, :children, :parent_id # А пачиму children не пропускает!!!
      )
    end
  end
end
