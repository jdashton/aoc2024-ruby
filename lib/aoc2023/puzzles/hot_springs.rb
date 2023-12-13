# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 12, we're finding ways to fit damage patterns.
    class HotSprings
      def self.day12
        condition_records = File.open('input/day12.txt') { |file| new file }
        puts "Day  12, Part One: #{ condition_records.find_arrangements } is the sum of those counts."
        # puts "Day  12, Part Two: #{ $INSTANCE_NAME.total_winnings_with_joker } are the new total winnings."
        puts
      end

      def initialize(file)
        @lines = file.readlines(chomp: true)
      end

      def construct_regex(groups) = Regexp.new "^\\.*#{ groups.map { |group| "#\{#{ group }}" }.join('\.+') }\\.*$"

      def find_arrangements_for_record(record, groups)
        puts
        puts "Record #{ record } has #{ groups } groups."
        regex = construct_regex(groups)

        total_sharps   = groups.sum
        missing_sharps = total_sharps - record.count(?#)
        # puts "Record #{ record } has #{ total_sharps } sharps and #{ missing_sharps } missing sharps."
        total_qms = record.count(??)
        # puts "Record #{ record } has #{ total_qms } question marks."
        # pp missing_chars = ([?#] * missing_sharps) + ([?.] * (total_qms - missing_sharps))
        missing_chars = (0...total_qms)
                          .to_a
                          .combination(missing_sharps)
                          .map { _1.each_with_object([?.] * total_qms) { |pos, acc| acc[pos] = ?# } }

        format_string = record.gsub(??, '%c')

        missing_chars.select { regex.match? format_string % _1 }.count
      end

      def find_arrangements_for(line)
        record, groups = line.split
        groups         = groups.split(',').map(&:to_i)
        find_arrangements_for_record(record, groups)
      end

      def find_arrangements
        @lines.map { find_arrangements_for _1 }.sum
      end
    end
  end
end
