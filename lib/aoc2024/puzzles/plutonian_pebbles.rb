# frozen_string_literal: true

require_relative '../helpers/string_helpers'
require_relative '../helpers/number_formatting'

module AoC2024
  module Puzzles
    # For Day 11, we're counting blinks.
    class PlutonianPebbles
      using StringHelpers
      using NumberFormatting

      def self.day11
        pebbles = File.open('input/day11.txt') { |file| PlutonianPebbles.new file }
        puts "Day 11, Part One: #{ pebbles.blink(25).with_commas } is how many stones we will have after blinking 25 times."
        puts "Day 11, Part Two: #{ pebbles.blink(75).with_commas } is how many stones we will have after blinking 75 times."

        puts
      end

      def initialize(file)
        @list  = file.readlines(chomp: true).first.split
        @cache = {}
      end

      def split_stone(stone_number, remaining_blinks)
        count_stones(stone_number.first_half, remaining_blinks) + count_stones(stone_number.last_half, remaining_blinks)
      end

      def count_stones(stone_number, blinks)
        return 1 if blinks.zero?

        remaining_blinks = blinks - 1
        @cache[[stone_number, blinks]] ||= case
                                             when stone_number == ?0 then count_stones(?1, remaining_blinks)
                                             when stone_number.length.even? then split_stone(stone_number, remaining_blinks)
                                             else count_stones((stone_number.to_i * 2024).to_s, remaining_blinks)
                                           end
      end

      def blink(num_blinks)
        @list.reduce(0) { |sum, n| (sum + count_stones(n, num_blinks)) }
      end
    end
  end
end
