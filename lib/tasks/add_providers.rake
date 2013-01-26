task :addproviderstorailscasts => :environment do
  # http://railscasts.com/episodes/66-custom-rake-tasks
  
  resources = Resource.all
  resources.each do |resource|
    p resource
    if resource.title_from_source && resource.title_from_source.include?('RailsCasts')
      resource.provider = 'RailsCasts, Ryan Bates'
      resource.save
      print resource.title_from_source
      print resource.provider
    else
      print 'not' + resource.title_from_source
    end
  end
end