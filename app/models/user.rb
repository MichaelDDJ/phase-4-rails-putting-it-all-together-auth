class User < ApplicationRecord
    has_many :recipes, dependent: :destroy
    has_secure_password
    validates :username, uniqueness: true
    validates :username, presence: true
end
