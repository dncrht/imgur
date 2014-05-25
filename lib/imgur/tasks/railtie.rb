module Imgur
  module Tasks
    class Railtie < Rails::Railtie
      rake_tasks do
        load 'imgur/tasks/tasks.rake'
      end
    end
  end
end

