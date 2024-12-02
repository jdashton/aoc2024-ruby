# frozen_string_literal: true

module AoC2024
  module Puzzles
    # For Day 11, we're finding the shortest paths (again).
    class CosmicExpansion
      def self.day11
        galaxy_map = File.open('input/day11.txt') { |file| new file }
        puts "Day  11, Part One: #{ galaxy_map.find_shortest_paths_sum } is the sum of all shortest paths."
        puts "Day  11, Part Two: #{ galaxy_map.find_shortest_paths_sum(1_000_000) } is the sum of all shortest paths " \
               'in a greatly expanded universe.'
        puts
      end

      def initialize(file)
        @lines = file.readlines(chomp: true).map(&:chars)
      end

      def expand_universe
        @empty_rows    = @lines.each_index.select { |i| @lines[i].all?(?.) }
        @lines         = @lines.transpose
        @empty_columns = @lines.each_index.select { |i| @lines[i].all?(?.) }
        @lines         = @lines.transpose
      end

      def find_shortest_paths(expansion_factor)
        galaxies_coordinates = collect_galaxy_coordinates
        calculate_paths(galaxies_coordinates, expansion_factor)
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

      def calculate_paths(coordinates, expansion_factor)
        # pp @empty_columns
        # pp @empty_rows
        @expansion_factor = expansion_factor
        coordinates.combination(2).map do |galaxy1, galaxy2|
          get_min_max_values(galaxy1, galaxy2)
            .then { |x_min, x_max, y_min, y_max| calculate_distance(x_min, x_max, y_min, y_max) }
        end
      end

      def get_min_max_values(galaxy1, galaxy2)
        x_min, x_max = [galaxy1[0], galaxy2[0]].minmax
        y_min, y_max = [galaxy1[1], galaxy2[1]].minmax
        [x_min, x_max, y_min, y_max]
      end

      def calculate_distance(x_min, x_max, y_min, y_max)
        [x_min, x_max, y_min, y_max]
        x_range         = x_min..x_max
        x_expansion_pts = @empty_columns.count { |x| x_range.include?(x) }

        y_range         = y_min..y_max
        y_expansion_pts = @empty_rows.count { |y| y_range.include?(y) }

        y_max - y_min + ((@expansion_factor - 1) * y_expansion_pts) +
          x_max - x_min + ((@expansion_factor - 1) * x_expansion_pts)
      end

      def find_shortest_paths_sum(expansion_factor = 2)
        expand_universe
        find_shortest_paths(expansion_factor).sum
      end
    end
  end
end
