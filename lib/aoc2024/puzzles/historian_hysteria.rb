# frozen_string_literal: true

require_relative '../helpers/number_formatting'

module AoC2024
  module Puzzles
    # For Day 1, we're finding differences.
    class HistorianHysteria
      using NumberFormatting

      def self.day01
        significant_locations = File.open('input/day01.txt') { |file| HistorianHysteria.new file }
        puts "Day  1, Part One: #{ significant_locations.sum_distances.with_commas } is is the total distance between lists."
        puts "Day  1, Part Two: #{ significant_locations.similarity_score.with_commas } is the similarity score."

        puts
      end

      def initialize(file)
        @lists = file.readlines(chomp: true).map { |list| list.split.map(&:to_i) }.transpose.map(&:sort)
      end

      def sum_distances
        last_list = @lists.last
        @lists.first.each_with_index.reduce(0) { |sum, (i, idx)| sum + (last_list[idx] - i).abs }
      end

      def similarity_score
        frequencies = @lists.last.group_by(&:itself).transform_values(&:size)
        @lists.first.reduce(0) { |sum, i| sum + (i * (frequencies[i] || 0)) }
      end
    end
  end
end
