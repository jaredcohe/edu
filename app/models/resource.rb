class Resource < ActiveRecord::Base
  attr_accessible :clean_url, :raw_url, :user_id, :title_from_user, :title_from_source, 
    :description_from_user, :description_from_source, :keywords_from_user,
    :keywords_from_source, :raw_html, :url_or_title, :provider

  has_many :reviews

  def parse_scraped_data(html)
    p 'running Resource#self.scrape_data in Resource model'
    
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
  end

  def self.search(search_term)
    if search_term
      where(["upper(title_from_user) LIKE upper(?) 
        OR upper(title_from_source) LIKE upper(?) 
        OR upper(description_from_user) LIKE upper(?) 
        OR upper(description_from_source) LIKE upper(?) 
        OR upper(keywords_from_user) LIKE upper(?) 
        OR upper(keywords_from_source) LIKE upper(?)",
         "%#{search_term}%", "%#{search_term}%", "%#{search_term}%",
         "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"])
    else
      scoped
    end
  end

  def self.full_search(search_term)
    if search_term
      #arel_table.[:title].matches(upper(?), )
      #where('upper(title) LIKE upper(?)', "%#{search_term}%".or('upper(description) LIKE upper(?)', "%#{search_term}%"))
      #Knowledge.where(Knowledge.arel_table[:title].matches("%ruby%").or(Knowledge.arel_table[:description].matches("%ruby%")))
    else
      scoped
    end
  end

  def self.description_search(search_term)
    if search_term
      where('upper(description) LIKE upper(?)', "%#{search_term}%")
    else
      scoped
    end
  end

  def self.category_search(search_term)
    if search_term
      joins(:categories).where("categories.name LIKE '%#{search_term}%'")
    else
      scoped
    end
  end

end