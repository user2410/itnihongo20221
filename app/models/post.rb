class Post < ApplicationRecord
	belongs_to :account, foreign_key: "user_id"
end
