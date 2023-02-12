class Post < ApplicationRecord
	belongs_to :account, foreign_key: 'user_id'
	has_and_belongs_to_many :topics
	has_many :account_post
	has_many :references
end
