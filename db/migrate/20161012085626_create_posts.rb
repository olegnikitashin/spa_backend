class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :body
      t.string :username

      t.timestamps
    end
  end
end
