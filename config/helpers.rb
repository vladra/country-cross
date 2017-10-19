def prod?
  ENV['RACK_ENV'] == 'production'
end

def dev?
  ENV['RACK_ENV'] == 'production'
end

def load_dir(dir)
  Dir["#{File.dirname(__FILE__)}/../#{dir}/**/*.rb"].each { |f| load(f) }
end
