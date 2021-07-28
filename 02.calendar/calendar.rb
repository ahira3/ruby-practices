#!/usr/bin/env ruby

require "Date"
require "optparse"

def calendar(year: Date.today.year, month: Date.today.month)
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

opts = ARGV.getopts("y:", "m:")
case 
when opts["y"] && opts["m"]
  calendar(year: opts["y"].to_i, month: opts["m"].to_i)
when opts["y"]
  calendar(year: opts["y"].to_i)
when opts["m"]
  calendar(month: opts["m"].to_i)
else
  calendar()
end
