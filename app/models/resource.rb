class Resource < ActiveRecord::Base
  attr_accessible :clean_url, :raw_url, :user_id, :title_from_user, :title_from_source, 
    :description_from_user, :description_from_source, :keywords_from_user,
    :keywords_from_source, :raw_html

  def parse_scraped_data(html)
    p 'running Resource#self.scrape_data in Resource model'
    
    #begin
      self.title_from_source = html.css("title").length > 0 ? html.css("title").text : nil
      
      if html.css("meta[name='description']").length > 0
        if html.css("meta[name='description']").first.attributes['content']
          self.description_from_source = html.css("meta[name='description']").first.attributes['content'].value
        elsif html.css("meta[name='description']").first.attributes['contents']
          self.description_from_source = html.css("meta[name='description']").first.attributes['contents'].value
        else
          self.description_from_source = nil
        end
      end

      if html.css("meta[name='keywords']").length > 0
        if html.css("meta[name='keywords']").first.attributes['content']
          self.keywords_from_source = html.css("meta[name='keywords']").first.attributes['content'].value
        elsif html.css("meta[name='keywords']").first.attributes['contents']
          self.keywords_from_source = html.css("meta[name='keywords']").first.attributes['contents'].value
        else
          self.keywords_from_source = nil
        end
      end

      self.keywords_from_source = html.css("meta[name='keywords']").length > 0 ? html.css("meta[name='keywords']").first.attributes['content'].value : ""
  #    resource_from_source[:good_url] = true
  #  rescue Exception
  #    resource_from_source[:good_url] = false
  #  end
  #  resource_from_source
  end

end