require_relative 'helpers'

require 'sequel'
require 'logger'

if prod? || ENV['DATABASE_URL']
  DB = Sequel.connect(ENV['DATABASE_URL'])
else
  DB = Sequel.sqlite('db.sqlite3')
end

DB.loggers << Logger.new($stdout) if dev?
