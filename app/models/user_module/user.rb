module UserModule
  class User < ActiveRecord::Base
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