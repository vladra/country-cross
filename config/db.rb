require_relative 'helpers'

require 'sequel'

if prod? || ENV['DATABASE_URL']
  DB = Sequel.connect(ENV['DATABASE_URL'])
else
  DB = Sequel.sqlite('app.db')
end

DB.loggers << Logger.new($stdout) if dev?
