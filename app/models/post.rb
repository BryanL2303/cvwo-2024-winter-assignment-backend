class Post < ApplicationRecord
    belongs_to :user
    has_many :post_labels
	has_many :labels, through: :post_labels
end
