# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 14, we're rolling rocks.
    class ParabolicReflectorDish
      def self.day14
        platform = File.open('input/day14.txt') { |file| new file }
        puts "Day  14, Part One: #{ platform.total_load_on_beams } is the total load on the north support beams."
        # puts "Day  14, Part Two: #{ $INSTANCE_NAME.total_winnings_with_joker } are the new total winnings."
        puts
      end

      def initialize(file)
        @lines = file.readlines(chomp: true)
      end

      def total_load_on_beams
        1
      end
    end
  end
end
