#!/usr/bin/env ruby
# frozen_string_literal: true

STRIKE_SCORE = 10
THROWING_COUNT_UNTIL_NINE_FRAME = 18

def get_frames(score)
  scores = score.split(',')
  shots = []
  scores.each do |s|
    if s == 'X'
      shots << STRIKE_SCORE
      shots << 0 if shots.size < THROWING_COUNT_UNTIL_NINE_FRAME
    else
      shots << s.to_i
    end
  end

  frames = []
  shots.each_slice(2) do |s|
    frames << s
  end
  if frames.size == 11
    frames[-2] << frames[-1][0]
    frames.pop
  end
  frames
end

def calc_score(frames)
  points = 0
  frames.each_with_index do |frame, i|
    points +=
      if frame[0] == 10 && i < 9
        calc_strike(frames, i)
      elsif frame.sum == 10 && frame[0] != 10
        frame.sum + frames[i + 1][0]
      else
        frame.sum
      end
  end
  points
end

def calc_strike(frames, index)
  if frames[index + 1][0] == 10
    if index < 8
      10 + 10 + frames[index + 2][0]
    else
      10 + 10 + frames[index + 1][1]
    end
  else
    10 + frames[index + 1][0] + frames[index + 1][1]
  end
end

if __FILE__ == $PROGRAM_NAME
  score = ARGV[0]
  frames = get_frames(score)
  points = calc_score(frames)
  puts points
end
