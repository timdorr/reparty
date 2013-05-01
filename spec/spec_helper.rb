$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'reparty'
require 'vcr_helper'

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

require 'action_mailer'
ActionMailer::Base.delivery_method = :test

require 'sqlite3'
require 'active_record'

ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.time_zone_aware_attributes = true

class User < ActiveRecord::Base
end

ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => 'test.db'
)

unless ActiveRecord::Base.connection.table_exists? "users"
  ActiveRecord::Migration.create_table :users do |t|
    t.string :name
    t.integer :score
    t.timestamps
  end
end