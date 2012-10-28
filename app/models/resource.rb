class Resource < ActiveRecord::Base
  attr_accessible :clean_url, :raw_url, :user_id, :title_from_user, :title_from_source, 
    :description_from_user, :description_from_source, :keywords_from_user,
    :keywords_from_source, :raw_html

  def self.scrape_data(raw_url)
    p 'running Resource#self.scrape_data in Resource model'

    require 'nokogiri'
    require 'open-uri'
    require 'net/http'
    require 'pp'

    resource_from_source = {}

    begin
      resource_from_source[:raw_html] = Net::HTTP.get URI.parse(raw_url)
      resource_from_source[:html] = Nokogiri::HTML(open(raw_url))
      resource_from_source[:title_from_source] = resource_from_source[:html].css("title").length > 0 ? resource_from_source[:html].css("title").text : nil
      if resource_from_source[:html].css("meta[name='description']").length > 0
        if resource_from_source[:html].css("meta[name='description']").first.attributes['content']
          resource_from_source[:description_from_source] = resource_from_source[:html].css("meta[name='description']").first.attributes['content'].value
        elsif resource_from_source[:html].css("meta[name='description']").first.attributes['contents']
          resource_from_source[:description_from_source] = resource_from_source[:html].css("meta[name='description']").first.attributes['contents'].value
        else
          resource_from_source[:description_from_source] = nil
        end
      end

      if resource_from_source[:html].css("meta[name='keywords']").length > 0
        if resource_from_source[:html].css("meta[name='keywords']").first.attributes['content']
          resource_from_source[:keywords_from_source] = resource_from_source[:html].css("meta[name='keywords']").first.attributes['content'].value
        elsif resource_from_source[:html].css("meta[name='keywords']").first.attributes['contents']
          resource_from_source[:keywords_from_source] = resource_from_source[:html].css("meta[name='keywords']").first.attributes['contents'].value
        else
          resource_from_source[:keywords_from_source] = nil
        end
      end

      # resource_from_source[:keywords_from_source] = resource_from_source[:html].css("meta[name='keywords']").length > 0 ? resource_from_source[:html].css("meta[name='keywords']").first.attributes['content'].value : ""
      resource_from_source[:good_url] = true
    rescue Exception
      resource_from_source[:good_url] = false
    end
    resource_from_source
  end

end