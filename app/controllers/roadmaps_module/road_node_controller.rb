module RoadmapsModule
  class RoadNodeController < ApplicationController
    before_action :authorize_request, only: [:create, :update, :destroy]
    before_action :find_road_node, except: [:create, :index]

    def index
      topic_id = params.permit(:topic_id)[:topic_id]
      nodes = RoadNode.where(:topic_id => topic_id)
      if nodes.count == 0
        render json: [],
               status: :ok
      else
        render json: RoadNodeHelper.genTreeResponse(nodes, nodes.where(:parent_id => nil)[0].attributes["id"]),
               status: :ok
      end
    end

    def show
      render json: @node, status: :ok
    end

    def create
      payload = road_node_params
      topic = Topic.find_by_id(payload[:topic_id])
      if topic != nil and (topic.created_user_id == @current_user.id or is_admin)
        node = RoadNode.new(payload)
        if node.save
          render json: node, status: :created
        else
          render json: { status: "Not Saved!" },
                 status: :unprocessable_entity
        end
      else
        render json: { errors: 'Permission Denied!' }, status: :unprocessable_entity
      end
    end

    def update
      if @node.topic.created_user_id == @current_user.id or is_admin
        unless @node.update(road_node_params)
          render json: { errors: @node.errors.full_messages },
                 status: :unprocessable_entity
        end
        render json: @node, status: :accepted
      else
        render json: { errors: 'Permission Denied!' }, status: :unprocessable_entity
      end
    end

    def destroy
      if @node.topic.created_user_id == @current_user.id or is_admin
        if @node.destroy
          RoadNodeHelper::removeRecursively(@node.id)
          render json: { status: 'Successfully deleted' }, status: :accepted
        end
      else
        render json: { errors: 'Permission Denied!' }, status: :unprocessable_entity
      end
    end

    private

    def find_road_node
      @node = RoadNode.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'RoadNode not found' }, status: :not_found
    end

    def road_node_params
      params.permit(
        :title, :description, :topic_id, :parent_id
      )
    end
  end
end
