module UserModule
  class UserRead < ActiveRecord::Base
    scope :filter_by_user_id, -> (user_id) { where user_id: user_id}

    belongs_to :user
    belongs_to :topic,:class_name => 'RoadmapsModule::Topic'
  end
end