# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 6, we're charging up boats for boat races.
    class WaitForIt
      def self.day06
        boat_races = File.open('input/day06.txt') { |file| WaitForIt.new file }
        puts "Day  6, Part One: #{ boat_races.race_ways } is the multiple of ways to beat the races."
        puts "Day  6, Part Two: #{ boat_races.race_ways_merged } is the number of ways to beat the one long race."
        puts
      end

      def initialize(file)
        @lines     = file.readlines(chomp: true)
        @times     = @lines[0].split[1..].map(&:to_i)
        @distances = @lines[1].split[1..].map(&:to_i)
      end

      def race_ways
        @times
          .zip(@distances)
          .map { |time, record_distance|
            low_time  = 1
            high_time = time - 1
            (low_time += 1) && high_time -= 1 while (low_time * high_time) <= record_distance

            # puts "low_time: #{ low_time } * #{ time - low_time }, max_time: #{ time }, " \
            # "record: #{ record_distance }, sqrt: #{ Math.sqrt(record_distance) }"
            high_time - low_time + 1
          }
          .reduce(&:*)
      end

      def race_ways_merged
        @times     = [@times.join.to_i]
        @distances = [@distances.join.to_i]
        race_ways
      end
    end
  end
end
