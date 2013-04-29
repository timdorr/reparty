require 'rails'

module Reparty
  class Engine < ::Rails::Engine
    isolate_namespace Reparty
  end
end