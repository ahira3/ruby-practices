# frozen_string_literal: true

require 'minitest/autorun'
require_relative './ls'

class LsTest < Minitest::Test
  def test_fetcn_file_list
    result = fetch_file_list
    expected = %w[a.txt b.txt c.txt d.txt e.txt f.txt g.txt ls.rb test_ls.rb]
    assert_equal expected, result
  end

  def test_transpose_file_list
    input = %w[a.txt b.txt c.txt d.txt e.txt f.txt g.txt ls.rb test_ls.rb]
    expected = [['a.txt', 'd.txt', 'g.txt'], ['b.txt', 'e.txt', 'ls.rb'], ['c.txt', 'f.txt', 'test_ls.rb']]
    assert_equal expected, transpose_file_list(input)
  end

  def test_fetch_all_file_list
    result = fetch_all_file_list
    expected = %w[. .. .gitkeep a.txt b.txt c.txt d.txt e.txt f.txt g.txt ls.rb test_ls.rb]
    assert_equal expected, result
  end

  def test_fetch_file_detail
    file = 'a.txt'
    result = fetch_file_detail(file)
    expected = { 'file_mode' => '-rw-r--r--', 'nlink' => 1, 'username' => 'ahirakawa', 'groupname' => 'staff', 'filesize' => 0, 'maketime' => ' 8  5 10:21',
                 'file' => 'a.txt' }
    assert_equal expected, result
  end

  def test_format_file_list_detail
    input = %w[a.txt b.txt c.txt ls.rb]
    expected = ['-rw-r--r--  1 ahirakawa  staff     0  8  5 10:21 a.txt',
                '-rw-r--r--  1 ahirakawa  staff     0  8  5 10:21 b.txt',
                '-rw-r--r--  1 ahirakawa  staff     0  8  5 10:21 c.txt',
                '-rwxr-xr-x  1 ahirakawa  staff  2917  8  8 16:51 ls.rb']
    assert_equal expected, format_file_list_detail(input)
  end

  def test_calc_blocks
    input = %w[a.txt b.txt c.txt d.txt e.txt f.txt g.txt ls.rb test_ls.rb]
    assert_equal 16, calc_blocks(input)
  end
end
