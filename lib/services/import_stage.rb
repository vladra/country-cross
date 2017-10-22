# coding: utf-8
require 'csv'
require_relative '../utilities/time_helpers'

X = %(№ п/п,ФИО,Класс,Круг 1,Круг 2,Круг 3,Круг 4,Круг 5,Круг 6,Круг 7,Круг 8,Круг 9,Круг 10,Колличество кругов,Общее время,Место
93,"""Ліфшиць Петро""",UTV,"00:06:59,68","00:06:56,30","00:07:00,01","00:07:10,31","00:07:28,38","00:07:03,49","00:06:51,81","00:06:54,21","00:07:00,52","00:07:08,76",10,"01:10:33,47",1
11,"""Драло Володимир""",UTV,"00:07:21,21","00:07:04,42","00:06:59,70","00:06:59,71","00:07:02,02","00:07:02,10","00:06:59,97","00:06:58,75","00:07:04,79","00:07:26,93",10,"01:10:59,60",2
26,"""Попов Євгеній""",UTV,"00:07:43,38","00:07:44,82","00:07:41,54","00:07:34,04","00:07:31,60","00:07:37,25","00:07:29,02","00:07:31,82","00:07:23,99",,9,"01:08:17,46",3
42,"""Фотул Вадім""",UTV,"00:07:21,93","00:07:24,05","00:07:42,64","00:07:35,33",,,,,,,4,"00:30:03,95",4
12,"""Барабаш Володимир""",UTV,"00:06:46,29","00:06:44,64","00:13:38,29","00:08:50,42",,,,,,,4,"00:35:59,64",5
)

class Services::ImportStage
  HEADERS = %i[number name type]
  LAP_HEADER_REGEX = /Круг (?<number>\d{1,2})/i

  def initialize(stage, csv)
    @stage = stage
    @data = CSV.new(csv, headers: true)

    @time_helper = Utilities::TimeHelpers.new
  end

  def call
    process_data
  end

  private

  def process_data
    @data.each { |row| process_racer(row) }
  end

  def process_racer(row)
    number = row[0]
    name = row[1]
    klass = row[2]

    racer = Racer.find_or_create(name: name, number: number, klass: klass)

    @stage.add_racer(racer)

    process_laps(racer, row)
  end

  def process_laps(racer, row)
    row.each do |header, value|
      match = header.match(LAP_HEADER_REGEX)

      next unless match && value

      n = match[:number]
      time = @time_helper.time_to_ms(value)
      racer.add_lap(stage: @stage, number: n, time: time)
    end
  end
end
