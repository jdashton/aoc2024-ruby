# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 12, we're finding ways to fit damage patterns.
    class HotSprings
      def self.day12
        condition_records = File.open('input/day12.txt') { |file| new file }
        puts "Day  12, Part One: #{ condition_records.find_arrangements } is the sum of those counts."
        # puts "Day  12, Part Two: #{ $INSTANCE_NAME.total_winnings_with_joker } are the new total winnings."
        puts
      end

      def initialize(file)
        @lines = file.readlines(chomp: true)
      end

      def construct_regex(groups) = Regexp.new "^\\.*#{ groups.map { |group| "#\{#{ group }}" }.join('\.+') }\\.*$"

      def count_matching_arrangements(record, groups)
        regex         = construct_regex(groups)
        total_qms     = record.count(??)
        record_with_placeholders = record.gsub(??, '%c')

        (0...total_qms)
          .to_a
          .combination(groups.sum - record.count(?#))
          .map { |selected_positions| substitute_positions(selected_positions, total_qms) }
          .select { |permutation| regex.match? record_with_placeholders % permutation }
          .count
      end

      def substitute_positions(selected_positions, total_qms)
        selected_positions.each_with_object([?.] * total_qms) { |pos, acc| acc[pos] = ?# }
      end

      def find_arrangements_for(line)
        record, groups = line.split
        groups         = groups.split(',').map(&:to_i)
        count_matching_arrangements(record, groups)
      end

      def find_arrangements
        @lines.map { find_arrangements_for _1 }.sum
      end
    end
  end
end
