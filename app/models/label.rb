class Label < ApplicationRecord
    has_many :posts, through: 'post_labels'
end
