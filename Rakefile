# Migrate

migrate = lambda do |env, version|
  ENV['RACK_ENV'] = env
  require_relative 'config/db'
  require 'logger'
  Sequel.extension :migration
  DB.loggers << Logger.new($stdout)
  Sequel::Migrator.apply(DB, 'migrate', version)
end

namespace :db do
  desc 'Seed database'
  task :seed do
    require_relative 'config/db'
    require_relative 'tasks/seeds'
    seed!
  end

  namespace :migrate do
    desc 'Migrate test database to latest version'
    task :test do
      migrate.call('test', nil)
    end

    desc 'Migrate development database to latest version'
    task :dev do
      migrate.call('development', nil)
    end

    desc 'Migrate production database to latest version'
    task :prod do
      migrate.call('production', nil)
    end
  end

  namespace :rollback do
    desc 'Migrate test database all the way down'
    task :test do
      migrate.call('test', 0)
    end

    desc 'Migrate development database to all the way down'
    task :dev do
      migrate.call('development', 0)
    end
  end

  namespace :reset do
    desc 'Migrate test database all the way down and then back up'
    task :test do
      migrate.call('test', 0)
      Sequel::Migrator.apply(DB, 'migrate')
    end

    desc 'Migrate development database all the way down and then back up'
    task :dev do
      migrate.call('development', 0)
      Sequel::Migrator.apply(DB, 'migrate')
    end
  end
end

# Shell

irb = proc do |env|
  ENV['RACK_ENV'] = env
  trap('INT', 'IGNORE')
  sh 'pry -r ./app'
end

desc 'Open irb shell in development mode'
task :console do
  irb.call('development')
end

namespace :console do
  desc 'Open irb shell in test mode'
  task :test do
    irb.call('test')
  end

  desc 'Open irb shell in development mode'
  task :dev do
    irb.call('development')
  end

  desc 'Open irb shell in production mode'
  task :prod do
    irb.call('production')
  end
end

# Specs

spec = proc do |pattern|
  sh "#{FileUtils::RUBY} -e 'ARGV.each{|f| require f}' #{pattern}"
end

desc 'Run all specs'
task default: %i[model_spec web_spec]

desc 'Run model specs'
task :model_spec do
  spec.call('./spec/model/*_spec.rb')
end

desc 'Run web specs'
task :web_spec do
  spec.call('./spec/web/*_spec.rb')
end
