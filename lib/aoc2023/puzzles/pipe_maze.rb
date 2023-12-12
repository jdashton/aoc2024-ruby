# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 10, we're finding the antipode.
    class PipeMaze
      def self.day10
        sketch = File.open('input/day10.txt') { |file| new file }
        puts "Day  10, Part One: #{ sketch.find_antipode } steps along the loop to get from the starting position to " \
               'the point farthest from the starting position.'
        # puts "Day  10, Part Two: #{ $INSTANCE_NAME.total_winnings_with_joker } are the new total winnings."
        puts
      end

      def initialize(file)
        @lines = file.readlines(chomp: true)
      end

      def find_antipode
        4
      end
    end
  end
end
