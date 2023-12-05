# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 1, we're finding digits in art.
    class Trebuchet
      def self.day01
        calibration_value_lines = File.open('input/day01.txt') { |file| Trebuchet.new file }
        puts "Day  1, Part One: #{ calibration_value_lines.sum_numbers } is the sum of all of the calibration values."
        puts "Day  1, Part Two: #{ calibration_value_lines.sum_with_words } is the sum of all of the " \
             'calibration values, including words.'
        puts
      end

      def initialize(file)
        @lines = file.readlines(chomp: true)
      end

      VALS = {
        'one'   => 1,
        'two'   => 2,
        'three' => 3,
        'four'  => 4,
        'five'  => 5,
        'six'   => 6,
        'seven' => 7,
        'eight' => 8,
        'nine'  => 9,
        '0'     => 0,
        '1'     => 1,
        '2'     => 2,
        '3'     => 3,
        '4'     => 4,
        '5'     => 5,
        '6'     => 6,
        '7'     => 7,
        '8'     => 8,
        '9'     => 9
      }.freeze

      def sum_numbers
        values = @lines.map do |line|
          /^.*?(?<tens>\d)/ =~ line
          /.*(?<ones>\d).*?$/ =~ line
          (VALS[tens] * 10) + VALS[ones]
        end
        values.sum
      end

      def sum_with_words
        values = @lines.map do |line|
          /^.*?(?<tens>\d|one|two|three|four|five|six|seven|eight|nine)/ =~ line
          /.*(?<ones>\d|one|two|three|four|five|six|seven|eight|nine).*?$/ =~ line
          (VALS[tens] * 10) + VALS[ones]
        end
        values.sum
      end
    end
  end
end
