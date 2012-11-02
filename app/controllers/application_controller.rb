class ApplicationController < ActionController::Base
  protect_from_forgery

  def scrape_resource(raw_url)
    require 'nokogiri'
    require 'open-uri'
    require 'net/http'
    require 'pp'

    raw_scraped_data = {}
    begin
      raw_scraped_data[:raw_html] = Net::HTTP.get URI.parse(raw_url)
      raw_scraped_data[:html] = Nokogiri::HTML(open(raw_url))
    rescue
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