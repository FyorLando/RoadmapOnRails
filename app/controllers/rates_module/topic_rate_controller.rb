module RatesModule
  class TopicRateController < ApplicationController
    before_action :authorize_request
    before_action :find_topic_rate, except: %i[create index]

    def index
      @topic_rates = TopicRate.all
      render json: @topic_rates, status: :ok
    end

    def show
      render json: @topic_rate, status: :ok
    end

    def create
      @topic_rate = TopicRate.new(topic_rate_params)
      @topic_rate.created_user_id = @current_user.id
      if @topic_rate.save
        render json: @topic_rate, status: :created
      else
        render json: { errors: @topic_rate.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def update
      if @topic_rate.user_id == @current_user.id or is_admin
        unless @topic_rate.update(topic_rate_upd_params)
          render json: { errors: @topic_rate.errors.full_messages },
                 status: :unprocessable_entity
        end
        render json: @topic_rate, status: :accepted
      else
        render json: { errors: 'Permission Denied!' }, status: :unprocessable_entity
      end
    end

    def destroy
      if @topic_rate.user_id == @current_user.id or is_admin
        if @topic_rate.destroy
          render json: 'Successfully deleted', status: :accepted
        end
      else
        render json: { errors: 'Permission Denied!' }, status: :unprocessable_entity
      end
    end

    private

    def find_topic_rate
      @topic_rate = RatesModule::TopicRate.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'TopicRate not found' }, status: :not_found
    end

    def topic_rate_params
      params.permit(
        :comment, :rate, :topic_id
      )
    end

    def topic_rate_upd_params
      params.permit(
        :comment, :rate
      )
    end
  end

end