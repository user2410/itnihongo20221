class CreateAccountPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :account_posts do |t|
      t.integer :account_id
      t.integer :post_id
      t.integer :reaction

      t.timestamps
    end
  end
end
