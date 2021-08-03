#!/usr/bin/env ruby

require "Date"
require "optparse"

def calendar(year:, month:)
  firstday = Date.new(year, month, 1)
  firstday_wday = Date.new(year, month, 1).wday
  lastday = Date.new(year, month, -1)
  calendar_head = firstday.strftime("%-m月, %Y")
  weekday = ["日", "月", "火", "水", "木", "金", "土"]
  puts calendar_head.center(20)
  puts weekday.join(" ")
  print "   " * firstday_wday
  (firstday..lastday).each do |date|
    print date.day.to_s.rjust(2) + " "
    puts "\n" if date.saturday?
  end
end


opts = ARGV.getopts('y:', 'm:')
year = if opts['y']
         opts['y'].to_i
       else
         Date.today.year
       end
month = if opts['m']
          opts['m'].to_i
        else
          Date.today.month
        end
calendar(year: year, month: month)
