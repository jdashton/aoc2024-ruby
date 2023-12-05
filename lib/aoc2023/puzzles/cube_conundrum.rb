# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 2, we're playing with colored cubes in a bag.
    class CubeConundrum
      def self.day02
        cube_games = File.open('input/day02.txt') { |file| CubeConundrum.new file }
        puts "Day  2, Part One: #{ cube_games.possible_games_ids_sum } is the sum of the IDs of those games."
        # puts "Day  2, Part Two: #{ cube_games.sum_with_words } is the sum of all of the " \
        #      'calibration values, including words.'
        puts
      end

      def initialize(file)
        @games = file.readlines(chomp: true)
      end

      GOALS = {
        'red'   => 12,
        'green' => 13,
        'blue'  => 14
      }.freeze

      def parse_line(line)
        /^Game (?<game_id>\d+): (?<rest>.*)$/ =~ line
        plays = rest.split(';')
        plays.each do |play|
          cubes = play.split(',')
          cubes.each do |cube|
            # pp cube
            /(?<num>\d+) (?<color>blue|red|green)/ =~ cube
            # pp num
            # pp color
            return 0 if num.to_i > GOALS[color]
          end
        end

        game_id.to_i
      end

      def possible_games_ids_sum
        @games.map { |game| parse_line(game) }.sum
      end

      def parse_for_power(line)
        cube_counts = { 'red' => 0, 'green' => 0, 'blue' => 0 }
        /^Game (?<game_id>\d+): (?<rest>.*)$/ =~ line
        plays = rest.split(';')
        plays.each do |play|
          cubes = play.split(',')
          cubes.each do |cube|
            # pp cube
            /(?<num>\d+) (?<color>blue|red|green)/ =~ cube
            # pp num
            # pp color
            # pp cube_counts[color]
            cube_counts[color] = [cube_counts[color], num.to_i].max
          end
        end

        cube_counts['red'] * cube_counts['blue'] * cube_counts['green']
      end

      def minimal_powers
        @games.map { |game| parse_for_power(game) }.sum
      end
    end
  end
end
