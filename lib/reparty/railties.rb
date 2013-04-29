module Reparty
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/reparty.rake"
    end
  end
end