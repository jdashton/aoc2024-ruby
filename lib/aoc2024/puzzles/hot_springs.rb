# frozen_string_literal: true

module AoC2024
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
        # puts "record: #{ record }, groups: #{ groups }"
        regex                    = construct_regex(groups)
        total_qms                = record.count(??)
        record_with_placeholders = record.gsub(??, '%c')

        (0...total_qms)
          .to_a
          # .tap { pp _1 }
          .combination(groups.sum - record.count(?#))
          # .tap { pp _1 }
          .map { |selected_positions| substitute_positions(selected_positions, total_qms) }
          # .tap { pp _1 }
          .select { |permutation| regex.match? record_with_placeholders % permutation }
          # .tap { pp _1 }
          .count
      end

      def substitute_positions(selected_positions, total_qms)
        selected_positions.each_with_object([?.] * total_qms) { |pos, acc| acc[pos] = ?# }
      end

      def find_arrangements_for(line, unfold: false)
        record, groups = line.split

        if unfold
          record = ([record] * 5).join(??)
          groups = ([groups] * 5).join(?,)
        end

        groups = groups.split(',').map(&:to_i)
        count_matching_arrangements(record, groups)
      end

      def find_arrangements
        @lines.map { find_arrangements_for _1 }.sum
      end

      def find_unfolded_arrangements
        @lines.map { find_arrangements_for _1, unfold: true }.sum
      end

      # def solve(springs, groups, cache, i)
      #   #         if num groups is 0:
      #   #           if any '#' remaining in springs return 0
      #   #           else return 1
      #   if groups.empty?
      #     return 0 if springs.any?(?#)
      #
      #     return 1
      #   end
      #
      #   #           advance i to the next available '?' or '#'
      #   i = springs.index { |c| c == ?# || c == ?? } if i >= springs.length
      #
      #   #           if i > length of springs return 0
      #   return 0 if i >= springs.length
      #
      #   #           if (i, num groups) is in cache, return it
      #   return cache[[i, groups]] if cache.key?([i, groups])
      #
      #   result = 0
      #
      #   #           if we can fill the springs at i with the first group in groups:
      #   #             recursively call with the groups after that at index: i + groupsize + 1
      #   if can_fill_springs?(springs, groups.first, i)
      #     result += solve(springs, groups[1..], cache, i + groups.first.length + 1)
      #   end
      #
      #   #           if the current spot is '?':
      #   #                                    recursively call with current groups at the next index
      #   if springs[i] == ?? && result.zero?
      #     result += solve(springs, groups, cache, i + 1)
      #   end
      #
      #   #           add the result to the cache
      #   cache[[i, groups]] = result
      #
      #   #           return result
      # end
    end
  end
end
