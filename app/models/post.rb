class Post < ApplicationRecord
    belongs_to :user
	belongs_to :label, optional: true
end
