#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  opt = ARGV.getopts('l')
  files = ARGV
  if opt['l']
    if files.size > 1
      print_l_option_some_files(files)
    elsif files.size.zero?
      input = $stdin.read
      puts calc_number_of_line(input).to_s.rjust(8).to_s
    else
      puts "#{calc_number_of_line(File.read(files.first)).to_s.rjust(8)} #{files.first}"
    end
  elsif files.size.zero?
    input = $stdin.read
    print_file_info(calc_all_data(input))
  elsif files.size > 1
    print_some_files_info(calc_some_files(files))
  else
    print_file_info(calc_all_data(File.read(files.first)))
    print " #{files.first}"
  end
end

def calc_number_of_line(file_info)
  file_info.count("\n")
end

def calc_number_of_word(file_info)
  file_info.split(/\s+/).size
end

def calc_file_size(file_info)
  file_info.bytesize
end

def calc_all_data(file_info)
  lines = calc_number_of_line(file_info).to_s.rjust(8)
  words = calc_number_of_word(file_info).to_s.rjust(8)
  bytes = calc_file_size(file_info).to_s.rjust(8)
  [lines, words, bytes]
end

def calc_some_files(files)
  lines_total = 0
  words_total = 0
  bytes_total = 0
  files_info = []
  files.map do |file|
    file_info = File.read(file)
    lines_total += calc_number_of_line(file_info)
    words_total += calc_number_of_word(file_info)
    bytes_total += calc_file_size(file_info)
    files_info << calc_all_data(file_info)
  end
  files_info.each_with_index do |info, i|
    info << " #{files[i]}"
  end
  files_info << [lines_total.to_s.rjust(8), words_total.to_s.rjust(8), bytes_total.to_s.rjust(8), ' total']
end

def print_some_files_info(files_info)
  files_info.map do |infos|
    print_file_info(infos)
    puts
  end
end

def print_l_option_some_files(files)
  total = 0
  files.each do |file|
    total += calc_number_of_line(File.read(file))
    puts "#{calc_number_of_line(File.read(file)).to_s.rjust(8)} #{file}"
  end
  puts "#{total.to_s.rjust(8)} total"
end

def print_file_info(input)
  input.map do |d|
    print d
  end
end

main if __FILE__ == $PROGRAM_NAME
