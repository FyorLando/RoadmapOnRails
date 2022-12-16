module UserModule
  class Role < ActiveRecord::Base
    has_many :users
  end
end