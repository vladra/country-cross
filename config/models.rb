require_relative 'helpers'
require_relative 'db'

if dev?
  Sequel::Model.cache_associations = false
end

load_dir('models')

if prod?
  Sequel::Model.freeze_descendents
  DB.freeze
end
