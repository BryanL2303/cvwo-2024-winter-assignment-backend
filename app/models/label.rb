class Label < ApplicationRecord
    has_mane :post_labels
    has_many :posts, through: :post_labels
end
