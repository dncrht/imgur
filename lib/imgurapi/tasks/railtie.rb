module Imgurapi
  module Tasks
    class Railtie < Rails::Railtie
      rake_tasks do
        load 'imgurapi/tasks/tasks.rake'
      end
    end
  end
end

