class Post < ApplicationRecord
	belongs_to :account, foreign_key: "user_id"
	has_many :account_post
	has_many :references
end
