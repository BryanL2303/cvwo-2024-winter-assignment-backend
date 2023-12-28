class Post < ApplicationRecord
    belongs_to :user
	has_and_belongs_to_many :label, join_table: 'post_labels'
end
