class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.text :title
      t.text :body
      t.integer :score
      t.integer :resource_id

      t.timestamps
    end
  end
end
