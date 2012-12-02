require 'imgur' # We need HOST to be available
require 'imgur/rake'

namespace :imgur do
  desc 'Obtain your Imgur tokens'
  task :authorize do
    if ENV['APP_KEY'].nil? or ENV['APP_SECRET'].nil?
      puts "USAGE: `rake imgur:authorize APP_KEY=your_app_key APP_SECRET=your_app_secret`"
      exit
    end

    Imgur::Rake.authorize(ENV['APP_KEY'], ENV['APP_SECRET'])
  end
end
