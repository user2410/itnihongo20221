class CreateJoinTablePostsTopics < ActiveRecord::Migration[6.0]
  def change
    create_join_table :posts, :topics do |t|
      # t.index [:post_id, :topic_id]
      # t.index [:topic_id, :post_id]
    end
  end
end
