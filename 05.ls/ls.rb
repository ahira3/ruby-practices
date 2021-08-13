#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'
require 'optparse'
COLUMN_SIZE = 3

def main
  options = ARGV.getopts('alr')
  files = options['a'] ? fetch_all_file_list : fetch_file_list
  files.reverse! if options['r']
  if options['l']
    puts "total #{calc_blocks(files)}"
    puts format_file_list_detail(files)
  else
    max_filename_length = files.map(&:size).max
    transpose_file_list(files).each do |transpose_files|
      transpose_files.each do |file|
        print file.ljust(max_filename_length)
        print("\t")
      end
      puts
    end
  end
end

def convert_to_mode(mode)
  {
    '7' => 'rwx',
    '6' => 'rw-',
    '5' => 'r-x',
    '4' => 'r--',
    '3' => '-wx',
    '2' => '-w-',
    '1' => '--x',
    '0' => '---'
  }[mode.to_s]
end

def convert_to_ftype(ftype)
  {
    file: '-',
    directory: 'd',
    characterSpecial: 'c',
    blockSpecial: 'b',
    fifo: 'p',
    link: 'l',
    socket: 's'
  }[ftype.to_sym]
end

def fetch_file_list
  Dir.glob('*')
end

def fetch_all_file_list
  Dir.glob('*', File::FNM_DOTMATCH)
end

def fetch_file_detail(file)
  stats = File.stat(file)
  file_mode = stats.mode.to_s(8)[-3, 3].split('').map { |c| convert_to_mode(c) }
  file_type = convert_to_ftype(stats.ftype)
  file_mode = file_mode.unshift(file_type).join('')
  username = Etc.getpwuid(stats.uid).name
  groupname = Etc.getgrgid(stats.gid).name
  nlink = stats.nlink
  filesize = stats.size
  maketime = stats.mtime.strftime(' %-m  %-d %R')
  { file_mode: file_mode, nlink: nlink, username: username, groupname: groupname, filesize: filesize, maketime: maketime,
    file: file }
end

def transpose_file_list(files)
  max_files_count = (files.size.to_f / COLUMN_SIZE).ceil
  sliced_files = files.each_slice(max_files_count).to_a
  if sliced_files[-1].size < max_files_count
    number_add_blank = max_files_count - sliced_files[-1].size
    number_add_blank.times { sliced_files[-1] << '' }
  end
  # 3xnの配列にする
  sliced_files.transpose
end

def max_length_each_element(files, key)
  files.map do |file|
    info = fetch_file_detail(file)
    info[key].to_s.size
  end.max
end

def format_file_list_detail(files)
  files.map do |file|
    info = fetch_file_detail(file)
    info[:nlink] = info[:nlink].to_s.rjust(max_length_each_element(files, :nlink) + 1)
    info[:groupname] = info[:groupname].rjust(max_length_each_element(files, :groupname) + 1)
    info[:filesize] = info[:filesize].to_s.rjust(max_length_each_element(files, :filesize) + 1)
    info.values.join(' ')
  end
end

def calc_blocks(files)
  files.map do |file|
    File.stat(file).blocks
  end.sum
end

main
