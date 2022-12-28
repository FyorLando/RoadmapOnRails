module RoadmapsModule
  class TopicController < ApplicationController
    before_action :authorize_request, only: [:create, :update, :destroy]
    before_action :find_topic, except: [:create, :index]

    def index
      topics = Topic.all
      if topics.count == 0
        render json: [],
               status: :ok
      else
        render json: TopicHelper.GenTopicsResponse(topics),
               status: :ok
      end
    end

    def show
      render json: @topic, status: :ok
    end

    def create
      params = topic_params.to_hash
      params[:created_user_id] = @current_user.id
      @topic = Topic.new(params)
      if @topic.save
        render json: @topic, status: :created
      else
        render json: { errors: @topic.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def update
      if @topic.user.id == @current_user.id or is_admin
        unless @topic.update(topic_params)
          render json: { errors: @topic.errors.full_messages },
                 status: :unprocessable_entity
        end
        render json: @topic, status: :accepted
      else
        render json: { errors: 'Permission Denied!' }, status: :unprocessable_entity
      end
    end

    def destroy
      if @topic.user.id == @current_user.id or is_admin
        if @topic.destroy
          render json: 'Successfully deleted', status: :accepted
        end
      else
        render json: { errors: 'Permission Denied!' }, status: :unprocessable_entity
      end
    end

    private

    def find_topic
      @topic = Topic.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Topic not found' }, status: :not_found
    end

    def topic_params
      params.permit(
        :title, :description
      )
    end
  end
end
