class Resource < ActiveRecord::Base
  attr_accessible :clean_url, :description, :keywords_manual, :keywords_scraped, :raw_url, :title_manual, :title_scraped, :user_id
end
