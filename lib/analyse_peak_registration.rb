# frozen_string_literal: true

require 'csv'
require 'time'

def parse_datetime(date)
  Time.strptime(date, '%D %R')
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

registration_hours_arr = []
registration_weekdays_arr = []

contents.each do |row|
  registration_datetime = parse_datetime(row[:regdate])

  registration_hours_arr << registration_datetime.hour

  registration_weekday = registration_datetime.strftime('%A')
  registration_weekdays_arr << registration_weekday
end

peak_hours = registration_hours_arr.tally.sort_by(&:last).reverse.to_h
peak_weekdays = registration_weekdays_arr.tally.sort_by(&:last).reverse.to_h