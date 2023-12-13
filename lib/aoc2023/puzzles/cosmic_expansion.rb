# frozen_string_literal: true

require 'pp'

module AoC2023
  module Puzzles
    # For Day 11, we're finding the shortest paths (again).
    class CosmicExpansion
      def self.day11
        galaxy_map = File.open('input/day11.txt') { |file| new file }
        puts "Day  11, Part One: #{ galaxy_map.find_shortest_paths_sum } is the sum of all shortest paths."
        # puts "Day  11, Part Two: #{ $INSTANCE_NAME.total_winnings_with_joker } are the new total winnings."
        puts
      end

      def initialize(file)
        @lines = file.readlines(chomp: true).map(&:chars)
      end

      def expand_universe
        # pp @lines

        empty_lines = []
        @lines.each_index { |i| empty_lines << i if @lines[i].all?(?.) }
        empty_lines.reverse.each { |i| @lines.insert(i, @lines[i]) }

        # pp @lines

        @lines      = @lines.transpose
        empty_lines = []
        @lines.each_index { |i| empty_lines << i if @lines[i].all?(?.) }
        empty_lines.reverse.each { |i| @lines.insert(i, @lines[i]) }

        # PP.pp(@lines, $>, 80)

        @lines = @lines.transpose
        # PP.pp(@lines, $>, 80)
      end

      def find_shortest_paths
        galaxies_coordinates = collect_galaxy_coordinates
        calculate_paths(galaxies_coordinates)
      end

      def collect_galaxy_coordinates
        coordinates = []

        @lines.each_index do |y|
          @lines[y].each_index do |x|
            coordinates << [x, y] if @lines[y][x] == '#'
          end
        end

        coordinates
      end

      def calculate_paths(coordinates)
        coordinates.combination(2).map do |galaxy1, galaxy2|
          x_min, x_max, y_min, y_max = get_min_max_values(galaxy1, galaxy2)
          calculate_distance(x_min, x_max, y_min, y_max)
        end
      end

      def get_min_max_values(galaxy1, galaxy2)
        x_min, x_max = [galaxy1[0], galaxy2[0]].minmax
        y_min, y_max = [galaxy1[1], galaxy2[1]].minmax
        [x_min, x_max, y_min, y_max]
      end

      def calculate_distance(x_min, x_max, y_min, y_max)
        y_max - y_min + x_max - x_min
      end

      def find_shortest_paths_sum
        expand_universe
        find_shortest_paths.sum
      end
    end
  end
end
