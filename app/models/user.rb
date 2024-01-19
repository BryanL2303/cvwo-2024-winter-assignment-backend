class User < ApplicationRecord
    validates :username, presence: true
    validates :username, length: { minimum: 5}
    validates :username, uniqueness: { case_sensitive: false }
    validates :password, presence: true
    validates :password, length: { minimum: 5}
end
