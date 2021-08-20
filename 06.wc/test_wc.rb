# frozen_string_literal: true

require 'minitest/autorun'
require_relative './wc'

class WcTest < Minitest::Test
  def setup
    @input = File.read('test1.txt')
  end

  def test_calc_number_of_line
    assert_equal 3, calc_number_of_line(@input)
  end

  def test_calc_number_of_word
    assert_equal 4, calc_number_of_word(@input)
  end

  def test_calc_file_size
    assert_equal 26, calc_file_size(@input)
  end

  def test_calc_all_data
    expected = ['       3', '       4', '      26']
    assert_equal expected, calc_all_data(@input)
  end

  def test_calc_some_file
    files = ['test1.txt', 'test2.txt']
    expected = [['       3', '       4', '      26', ' test1.txt'], ['       6', '       8', '      54', ' test2.txt'], ['       9', '      12', '      80', ' total']]
    assert_equal expected, calc_some_files(files)
  end
end
