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
        @platform = file.readlines(chomp: true).map(&:chars)
      end

      def roll_left(platform)
        platform.map do |row|
          row
            .join
            .split(?#, -1)
            .map { |segment| "#{ ?O * segment.count(?O) }#{ ?. * segment.count(?.) }" }
            .join(?#)
            .chars
        end
      end

      def tilt(direction)
        adjusted_platform = adjust_platform_before_roll(@platform, direction)
        rolled_platform   = roll_left(adjusted_platform)
        adjust_platform_after_roll(rolled_platform, direction)
      end

      def adjust_platform_before_roll(platform, direction)
        # noinspection RubyCaseWithoutElseBlockInspection
        case direction
          when :west then platform
          when :east then platform.map(&:reverse)
          when :north then platform.transpose
          when :south then platform.transpose.map(&:reverse)
        end
      end

      def adjust_platform_after_roll(rolled_platform, direction)
        # noinspection RubyCaseWithoutElseBlockInspection
        case direction
          when :west then rolled_platform
          when :east then rolled_platform.map(&:reverse)
          when :north then rolled_platform.transpose
          when :south then rolled_platform.map(&:reverse).transpose
        end
      end

      def cycle(count)
        cache = {}
        start = repeat = cycle_length = 0
        (1..count).each do |i|
          @platform = tilt(:north)
          @platform = tilt(:west)
          @platform = tilt(:south)
          @platform = tilt(:east)
          if cache[@platform]
            # puts "Cycle #{ i } is the same as cycle #{ cache[@platform] }"
            start        = cache[@platform]
            repeat       = i
            cycle_length = repeat - start
            break
          else
            cache[@platform] = i
          end
        end
        return @platform if start.zero?

        inv_cache = cache.invert
        # pp [start, repeat, cycle_length]

        # pp((start...repeat).find { |i| i % cycle_length == count % cycle_length })

        # (start...repeat).each { |i| pp calculate_load(inv_cache[i]) }

        inv_cache[(start...repeat).find { |i| i % cycle_length == count % cycle_length }]
      end

      def calculate_load(frame = @platform)
        frame
          .reverse
          .map
          .with_index(1) { |row, index| index * row.count(?O) }
          .sum
      end

      def total_load_on_beams
        @platform = tilt(:north)
        calculate_load
      end

      def total_load_on_beams_after_billion
        frame = cycle(1_000_000_000)
        calculate_load frame
      end
    end
  end
end
