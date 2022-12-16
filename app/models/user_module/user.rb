module UserModule
  class User < ActiveRecord::Base

    has_many :topics, :class_name => 'RoadmapsModule::Topic', :foreign_key => 'created_user_id'
    has_many :user_reads, :class_name => 'UserModule::UserRead', :foreign_key => 'user_id'
    has_many :user_favourites, :class_name => 'UserModule::UserFavourite', :foreign_key => 'user_id'

    belongs_to :role
    def to_json(options={})
      options[:except] ||= [:password_digest]
      super(options)
    end


    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password,
              length: { minimum: 6 },
              if: -> { new_record? || !password.nil? }

  end
end