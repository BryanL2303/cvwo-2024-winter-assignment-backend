class Label < ApplicationRecord
    has_many :post_labels
    has_many :posts, through: :post_labels

    #Just in case, labels are created through seeds
    validates :label_name, presence: true
    validates :label_name, length: {minimum: 2}
end
