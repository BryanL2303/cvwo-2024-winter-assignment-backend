class Comment < ApplicationRecord
    belongs_to :user
	belongs_to :post, optional: true

    validates :comment, presence: true
    validates :comment, length: { minimum: 2 }
end
