module UserModule
  class UserRead < ActiveRecord::Base

    belongs_to :user
    belongs_to :node, :class_name => 'RoadmapsModule::RoadNode'
  end
end