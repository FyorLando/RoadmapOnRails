module RatesModule
  class TopicRate < ActiveRecord::Base
    belongs_to :user, :class_name => 'UserModule::User', :foreign_key => 'created_user_id'
    belongs_to :topic, :class_name => 'RoadmapsModule::Topic', :foreign_key => 'topic_id'
  end
end
