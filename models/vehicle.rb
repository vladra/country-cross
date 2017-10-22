class Vehicle < Sequel::Model
  one_to_many :racers
end
