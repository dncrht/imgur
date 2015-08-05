require 'imgurapi/tasks/rake'

namespace :imgur do
  desc 'Obtain your Imgur tokens'
  task :authorize do
    if ENV['CLIENT_ID'].nil? or ENV['CLIENT_SECRET'].nil?
      puts "USAGE: `rake imgur:authorize CLIENT_ID=your_client_id CLIENT_SECRET=your_client_secret`"
      exit
    end

    Imgurapi::Rake.authorize(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'])
  end
end
