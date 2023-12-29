class PostLabel < ApplicationRecord
    belongs_to :post
	belongs_to :label
end