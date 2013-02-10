class ApplicationController < ActionController::Base
  protect_from_forgery

  def fetch(uri, tries=0)
    pp "#{uri} and #{tries}"
    response = Net::HTTP.get_response(uri.host, uri.path)
    if tries < 4
      case response.code
      when '200'
        if response.body == ''
          tries = tries + 1
          fetch(uri, tries)
        else
          response
        end
      when '302'
        tries = tries + 1
        uri = URI(response['location'])
        pp uri
        fetch(uri, tries)
      end
    else
      false
    end
  end

  def scrape_resource(raw_url)
    require 'nokogiri'
    require 'open-uri'
    require 'net/http'
    require 'pp'

    raw_scraped_data = {}
    uri = URI(raw_url)
    resp = fetch(uri)
    
    if resp
      raw_scraped_data[:raw_html] = Net::HTTP.get URI.parse(raw_url)
      raw_scraped_data[:html] = Nokogiri::HTML(open(raw_url))      
    end
    raw_scraped_data
  end

private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user   # to access this method from the view

  def authorize
    redirect_to login_url, alert: "Not Authorized" if current_user.nil?
  end

end