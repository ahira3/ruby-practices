#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  opt_l, files = parse_input(args: ARGV)
  calc_results = calc(files: files)
  if calc_results.size <= 2
    print_file_info(format(calc_results, opt_l))
  else
    print_some_files_info(format(calc_results, opt_l))
  end
end

def parse_input(args:)
  opt_l = args[0] == '-l'
  if opt_l
    [true, args[1..-1]]
  else
    [false, args[0..-1]]
  end
end

def calc(files:)
  if files.length >= 1
    calc_some_files(files)
  else
    [calc_all_data($stdin.read)]
  end
end

def format(calc_results, opt_l)
  if opt_l
    format_l_option(calc_results)
  else
    format_no_option(calc_results)
  end
end

def format_l_option(calc_results)
  case calc_results.size
  when 1
    [calc_results.first[0]]
  when 2
    [calc_results.first[0], calc_results.first[-1]]
  else
    calc_results.map do |result|
      [result[0], result[-1]]
    end
  end
end

def format_no_option(calc_results)
  if calc_results.size <= 2
    calc_results.first
  else
    calc_results
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

def print_file_info(input)
  input.map do |d|
    print d
  end
end

main if __FILE__ == $PROGRAM_NAME
