class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :term
      t.string :description

      t.timestamps null: false
    end
  end
end
