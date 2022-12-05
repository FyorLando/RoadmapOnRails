module RoadmapsModule
  class Topic < ActiveRecord::Base
    belongs_to :user, :class_name => 'UserModule::User', :foreign_key => 'created_user_id'

    has_many :road_nodes
  end
end