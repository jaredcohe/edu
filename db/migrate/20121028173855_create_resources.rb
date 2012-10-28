class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.text :title_manual
      t.text :title_scraped
      t.string :raw_url
      t.string :clean_url
      t.text :description
      t.text :keywords_manual
      t.text :keywords_scraped
      t.integer :user_id

      t.timestamps
    end
  end
end
