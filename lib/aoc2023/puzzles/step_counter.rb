# frozen_string_literal: true

# require 'pp'

module AoC2023
  module Puzzles
    # For Day 21, we're counting steps.
    class StepCounter
      def self.day21
        map = File.open('input/day21.txt') { |file| new file }
        puts "Day  21, Part One: The Elf can reach #{ map.count_steps(64) } garden plots in exactly 64 steps."
        # puts "Day  21, Part Two: #{ map.count_steps } are the new total winnings."
        puts
      end

      def initialize(file)
        @garden_map = file.readlines(chomp: true)
      end

      STANDING_POSITION_CHARS = Set.new(%w[O S])

      def find_starting_positions(starting_map)
        starting_map.each_with_index.flat_map { |row, row_index|
          row.chars.each_with_index.map do |char, col_index|
            [row_index, col_index] if STANDING_POSITION_CHARS.include?(char)
          end
        }.compact
      end

      def neighbors(row, col, max_row, max_col)
        [
          row.positive? ? [row - 1, col] : nil,
          row < max_row ? [row + 1, col] : nil,
          col.positive? ? [row, col - 1] : nil,
          col < max_col ? [row, col + 1] : nil
        ].compact
      end

      def find_garden_plots((row, col), garden_map)
        neighbors(row, col, garden_map.size - 1, garden_map[row].size - 1)
          .filter { |plot| garden_map[plot.first][plot.last] == '.' }
      end

      def mark_one_step(position, starting_map)
        row, col               = position
        starting_map[row][col] = '.'
        find_garden_plots(position, starting_map).each { |plot| starting_map[plot.first][plot.last] = 'O' }
      end

      def take_steps(steps = 1, starting_map = @garden_map)
        steps.times do
          find_starting_positions(starting_map).each do |position|
            mark_one_step(position, starting_map)
          end
        end
        starting_map
      end

      def count_steps(steps = 6)
        # PP.pp @garden_map, $stdout, 80
        take_steps(steps).map { _1.count('O') }.sum
      end
    end
  end
end
