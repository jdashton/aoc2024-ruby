# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 3, we're looking for the missing part.
    class GearRatios
      def self.day03
        schematic = File.open('input/day03.txt') { |file| GearRatios.new file }
        puts "Day  3, Part One: #{ schematic.part_numbers_sum } " \
             'is the sum of all of the part numbers in the engine schematic.'
        puts "Day  3, Part Two: #{ schematic.gear_ratios_sum } " \
             'is the sum of all of the gear ratios in your engine schematic.'
        puts
      end

      def initialize(file)
        @lines       = file.readlines(chomp: true)
        @part_coords = Set.new
        @tag_coords  = Set.new
      end

      SYMBOL_CHARS = /[^.\d]/
      DIGITS       = /\d/
      NON_DIGITS   = /\D/

      def find_parts
        @lines.each_with_index do |line, i|
          cuts = "#{ line }.".split(SYMBOL_CHARS)[0..-2]
          j    = 0
          cuts&.each do |cut|
            j += cut.size
            @part_coords << [i, j]
            j += 1
          end
        end
      end

      def detect_tag((i, j))
        return false unless i >= 0 && i < @lines.count && DIGITS.match?(@lines[i][j])

        j -= 1 while j.positive? && DIGITS.match?(@lines[i][j - 1])
        @tag_coords << [i, j]
      end

      def find_numbers((i1, j))
        (i1 - 1..i1 + 1).map { |i|
          next 1 if detect_tag [i, j]

          (detect_tag([i, j - 1]) ? 1 : 0) + (detect_tag([i, j + 1]) ? 1 : 0)
        }.sum
      end

      def part_numbers_sum
        find_parts
        @part_coords.each { find_numbers(_1) }
        @tag_coords.map { |i, j| @lines[i][j..].to_i }.sum
      end

      def gear_ratios_sum
        find_parts
        @part_coords.map { |(i, j)|
          @tag_coords = Set.new
          next 0 unless @lines[i][j] == '*'
          next 0 unless find_numbers([i, j]) == 2

          @tag_coords.map { |(i2, j2)| @lines[i2][j2..].to_i }.reduce(:*)
        }.sum
      end
    end
  end
end
