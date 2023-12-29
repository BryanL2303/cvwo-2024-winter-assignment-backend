class Label < ApplicationRecord
    has_many :posts, through: :post_label
end
