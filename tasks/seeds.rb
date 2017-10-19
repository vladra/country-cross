# coding: utf-8
require_relative '../config/db'

def seed!
  DB[:stages].insert(
    name: 'Лабиринт Льва',
    location: 'Львов',
    date: Date.parse('2017-09-06')
  )

  polaris = DB[:vehicles].insert(brand: 'Polaris', model: 'RZR XP 1000')
  brp = DB[:vehicles].insert(brand: 'BRP', model: 'Maverick X3')

  DB[:racers].insert(name: 'Vlad', number: 11, vehicle_id: polaris)
  DB[:racers].insert(name: 'Petya', number: 93, vehicle_id: polaris)
end
