# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 5, we're mapping from seeds to locations.
    class IfYouGiveASeedAFertilizer
      def self.day05
        card_pile = File.open('input/day05.txt') { |file| IfYouGiveASeedAFertilizer.new file }
        puts "Day  5, Part One: #{ card_pile.lowest_location } is the lowest location number that corresponds to " \
             'any of the initial seed numbers'
        puts 'Day  5, Part Two: This take 7 hours and 31 minutes to run in the current implementation. Fix it.'
        puts
      end

      def initialize(file)
        @lines  = file.readlines(chomp: true)
        @seeds  = /seeds: (.*)/.match(@lines.first)[1].split.map(&:to_i)
        @layers = []
        construct_maps
      end

      # This method takes the layers of maps in the @layers instance variable and flattens them into a single
      # map that maps from all possible seed values to all possible location values.
      def flatten_layers
        # The following code suggested by Copilot, but probably does not produce a useful result.
        @layers.reduce({}) do |flattened, layer|
          layer.each do |src, dest|
            src.each do |src_num|
              dest.each do |dest_num|
                flattened[src_num] = dest_num
              end
            end
          end
          flattened
        end
      end

      def construct_maps
        @lines[1..].reject(&:empty?)
                   .each do |line|
          (@layers << []) && next if line.chars.last == ':'

          dest, src, len = line.split.map(&:to_i)
          @layers.last << [(src..src + len - 1), (dest..dest + len - 1)]
        end
      end

      def find_location(seed)
        @layers.reduce(seed) do |next_num, layer|
          ((src, dest = layer.find { _1[0].cover?(next_num) }) && (dest.min + (next_num - src.min))) || next_num
        end
      end

      def lowest_location
        @seeds.map { |seed| find_location(seed) }.min
      end

      # Thoughts on how to make this much faster:
      #   We only need to check the first element of each range of locations, mapping that back
      #   to a seed to see if we have any seed ranges overlapping with the ranges that can be
      #   translated into locations.
      #
      # To make this easier, try flattening the layers into a single layer that maps from all possible
      # seed values directly to all possible location values.
      #
      # Then start at the lowest location range, check to see if any of "our" seeds are in the range
      # we can backwards map from that lowest location range. Check the next location range, and so forth,
      # until we find a location range that overlaps with one of our seed ranges. The lowest seed in that
      # overlapping area will map to the lowest location, and the solution to the puzzle.
      #
      def lowest_location_with_seed_ranges
        @seeds
          .each_slice(2)
          .map { |start, len| (start..start + len - 1) }
          .map { |range|
            # puts "Checking range #{ range }"
            range.map { |seed| find_location(seed) }.min
          }.min
      end
    end
  end
end
