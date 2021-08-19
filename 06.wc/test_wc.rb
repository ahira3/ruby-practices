# frozen_string_literal: true

require 'minitest/autorun'
require_relative './wc'

class WcTest < Minitest::Test
  def setup
    @input = File.read('a.txt')
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
    files = ['a.txt', 'b.txt']
    expected = [['       3', '       4', '      26', ' a.txt'], ['       6', '       8', '      54', ' b.txt'], ['       9', '      12', '      80', ' total']]
    assert_equal expected, calc_some_files(files)
  end
end
