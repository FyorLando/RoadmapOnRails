module UserModule
  class UserFavourite < ActiveRecord::Base

    belongs_to :topic,:class_name => 'RoadmapsModule::Topic'

  end
end