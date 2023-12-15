# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 13, we're finding mirrors.
    class PointOfIncidence
      def self.day13
        mirror_map = File.open('input/day13.txt') { |file| new file }
        puts "Day  13, Part One: #{ mirror_map.find_reflections } is the number do you get after summing all my notes."
        # puts "Day  13, Part Two: #{ $INSTANCE_NAME.total_winnings_with_joker } are the new total winnings."
        puts
      end

      def initialize(file)
        @mirror_maps = file.readlines(chomp: true).slice_when { |a, b| a.empty? || b.empty? }.reject { _1 == [''] }
      end

      def check_reflection(mirror_map, index)
        mirror_map[index + 1..].zip(mirror_map[..index].reverse).reject { _1[1].nil? }.all? { _1[0] == _1[1] }
      end

      def lines_before_reflection(mirror_map)
        mirror_map.each_cons(2).with_index do |(line1, line2), index|
          pp index
          pp [line1, line2]
          return index + 1 if line1 == line2 && check_reflection(mirror_map, index)
        end
        nil
      end

      def find_reflections
        @mirror_maps
          .map { lines_before_reflection(_1.map(&:chars).transpose.map(&:join)) || (lines_before_reflection(_1) * 100) }
          .sum
      end
    end
  end
end
