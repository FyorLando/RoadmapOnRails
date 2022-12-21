module UserModule
  class UserRead < ActiveRecord::Base
    scope :filter_by_user_id, -> (user_id) { where user_id: user_id}

    belongs_to :user
    belongs_to :node, :class_name => 'RoadmapsModule::RoadNode'
  end
end