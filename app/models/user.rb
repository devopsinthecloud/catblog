class User < ApplicationRecord
    has_secure_password
    #validates :password, length: { minimum: 6 }, allow_blank: true
    #attr_accessor :email, :password, :password_confirmation
    validates_uniqueness_of :email
    has_one_attached :avatar
end
