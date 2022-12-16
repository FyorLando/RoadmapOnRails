module RatesModule
  class TopicRateController < ApplicationController
    before_action :authorize_request, except: :create
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
      if @topic_rate.save
        render json: @topic_rate, status: :created
      else
        render json: { errors: @topic_rate.errors.full_messages },
               status: :unprocessable_entity
      end
    end


    def update
      unless @topic_rate.update(topic_rate_params)
        render json: { errors: @topic_rate.errors.full_messages },
               status: :unprocessable_entity
      end
      render json: @topic_rate, status: :accepted
    end


    def destroy
      if @topic_rate.destroy
        render json: 'Successfully deleted', status: :accepted
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
        :comment, :rate
      )
    end

  end

end