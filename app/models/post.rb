class Post < ApplicationRecord
    belongs_to :user
    has_many :post_labels
	has_many :labels, through: :post_labels

    validates :title, presence: true
    validates :title, length: { minimum: 2}
    validates :title, uniqueness: { case_sensitive: false }
end
