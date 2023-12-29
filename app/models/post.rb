class Post < ApplicationRecord
    belongs_to :user
	has_many :labels, through: :post_label
end
