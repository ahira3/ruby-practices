# frozen_string_literal: true

require 'minitest/autorun'
require './bowling'

class BowlingTest < Minitest::Test
  def test_no_strike_and_spare
    input = [[1, 3], [4, 4], [3, 5], [4, 3], [2, 6], [6, 3], [4, 0], [4, 5], [3, 1], [4, 1]]
    assert_equal 66, calc_score(input)
  end

  def test_strike_consecutive
    input = [[0, 10], [1, 5], [0, 0], [0, 0], [10, 0], [10, 0], [10, 0], [5, 1], [8, 1], [0, 4]]
    assert_equal 107, calc_score(input)
  end

  def test_strike
    input = [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10, 0], [9, 1], [8, 0], [10, 0], [6, 4, 5]]
    assert_equal 139, calc_score(input)
  end

  def test_spare
    input = [[2, 8], [2, 3], [4, 5], [6, 4], [7, 1], [0, 10], [2, 3], [4, 6], [5, 4], [4, 6, 5]]
    assert_equal 107, calc_score(input)
  end

  def test_get_frames_10_frame_3_shots
    input = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    expect = [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10, 0], [9, 1], [8, 0], [10, 0], [6, 4, 5]]
    assert_equal expect, get_frames(input)
  end

  def test_get_frames_10_frame_2_shots
    input = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    expect = [[0, 10], [1, 5], [0, 0], [0, 0], [10, 0], [10, 0], [10, 0], [5, 1], [8, 1], [0, 4]]
    assert_equal expect, get_frames(input)
  end
end
