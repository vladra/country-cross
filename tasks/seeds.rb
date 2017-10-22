# coding: utf-8
require_relative '../config/db'
require_relative '../config/models'
require_relative '../lib/utilities/time_helpers'

def seed!
  s = Stage.new(
    name: 'Лабиринт Льва',
    location: 'Львов',
    date: Date.parse('2017-09-06')
  ).save


  polaris = Vehicle.new(brand: 'Polaris', model: 'RZR XP 1000', type: 'UTV').save
  brp = Vehicle.new(brand: 'BRP', model: 'Maverick X3', type: 'UTV Turbo').save

  v = Racer.new(name: 'Vlad', number: 11, vehicle: polaris).save
  p = Racer.new(name: 'Petya', number: 93, vehicle: polaris).save
  y = Racer.new(name: 'Yura', number: 111, vehicle: brp).save

  s.add_racer(v)
  s.add_racer(p)
  s.add_racer(y)

  s.add_lap(racer: v, number: 1, time: Utilities::TimeHelpers.new.time_to_ms("5:21.300"))
  s.add_lap(racer: v, number: 2, time: Utilities::TimeHelpers.new.time_to_ms("5:18.200"))
  s.add_lap(racer: v, number: 3, time: Utilities::TimeHelpers.new.time_to_ms("5:11.590"))

  s.add_lap(racer: p, number: 1, time: Utilities::TimeHelpers.new.time_to_ms("5:16.380"))
  s.add_lap(racer: p, number: 2, time: Utilities::TimeHelpers.new.time_to_ms("5:18.190"))
  s.add_lap(racer: p, number: 3, time: Utilities::TimeHelpers.new.time_to_ms("5:14.780"))

  s.add_lap(racer: y, number: 1, time: Utilities::TimeHelpers.new.time_to_ms("5:17.480"))
  s.add_lap(racer: y, number: 2, time: Utilities::TimeHelpers.new.time_to_ms("5:22.540"))
  s.add_lap(racer: y, number: 3, time: Utilities::TimeHelpers.new.time_to_ms("5:18.730"))
end
