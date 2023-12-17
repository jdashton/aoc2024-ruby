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

      def tilt_platform
        %i[north west south east].each { |direction| @platform = tilt(direction) }
      end

      def find_cache_target(goal, cycle_length, cycle_start)
        mod_at_goal = goal % cycle_length
        cycle_start.step.find { |i| i % cycle_length == mod_at_goal }
      end

      def cycle(goal)
        cache = {}

        cycle_start, cycle_length = compute_cycle(cache, goal)
        return @platform if cycle_start.zero?

        cache.invert[find_cache_target(goal, cycle_length, cycle_start)]
      end

      def compute_cycle(cache, count)
        1.upto(count) do |i|
          tilt_platform
          return calculate_cycle_parameters(cache[@platform], i) if cache[@platform]

          cache[@platform] = i
        end
        [0, 0]
      end

      def calculate_cycle_parameters(cycle_start, first_repeat)
        cycle_length = first_repeat - cycle_start
        [cycle_start, cycle_length]
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
