# frozen_string_literal: true

require 'minitest/autorun'
require_relative './wc'

class WcTest < Minitest::Test
  def setup
    @input = File.read('a.txt')
  end

  def test_load_number_of_line
    assert_equal 3, load_number_of_line(@input)
  end

  def test_load_number_of_word
    assert_equal 4, load_number_of_word(@input)
  end

  def test_load_file_size
    assert_equal 26, load_file_size(@input)
  end

  def test_load_all_data
    expected = ['       3', '       4', '      26']
    assert_equal expected, load_all_data(@input)
  end

  def test_load_some_file
    files = ['a.txt', 'ls.rb']
    expected = [['       3', '       4', '      26', ' a.txt'], ['     114', '     276', '    2834', ' ls.rb'], ['     117', '     280', '    2860', ' total']]
    assert_equal expected, load_some_files(files)
  end
end
