module RoadmapsModule
  class AttachmentController < ApplicationController
    before_action :authorize_request, only: [:create, :update, :destroy]
    before_action :find_attachment, except: [:create, :index]

    def index
      @attachments = Attachment.all
      render json: @attachments, status: :ok
    end

    def show
      render json: @attachment, status: :ok
    end

    def create
      road_node = RoadNode.find_by_id(attachment_params[:node_id])
      if road_node != nil and road_node.topic.created_user_id == @current_user.id or is_admin
        @attachment = Attachment.new(attachment_params)
        if @attachment.save
          render json: @attachment, status: :created
        else
          render json: { errors: @attachment.errors.full_messages },
                 status: :unprocessable_entity
        end
      else
        render json: { errors: 'RoadNode not found' }, status: :not_found
      end
    end

    def update
      road_node = RoadNode.find_by_id(attachment_params[:node_id])
      if road_node != nil and road_node.topic.created_user_id == @current_user.id or is_admin
        unless @attachment.update(attachment_params)
          render json: { errors: @attachment.errors.full_messages },
                 status: :unprocessable_entity
        end
        render json: @attachment, status: :accepted
      end
    end

    def destroy
      road_node = @attachment.road_node
      if road_node != nil and road_node.topic.created_user_id == @current_user.id or is_admin
        if @attachment.destroy
          render json: { status: 'Successfully deleted' }, status: :accepted
        else
          render json: { status: "Attachment Not Deleted!" },
                 status: :unprocessable_entity
        end
      else
        render json: { errors: 'RoadNode not found' }, status: :not_found
      end
    end

    private

    def find_attachment
      @attachment = Attachment.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Attachment not found' }, status: :not_found
    end

    def attachment_params
      params.permit(
        :node_id, :url
      )
    end
  end
end
