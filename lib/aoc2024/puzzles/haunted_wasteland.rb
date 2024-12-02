# frozen_string_literal: true

module AoC2024
  module Puzzles
    # For Day 8, we're turning left and right.
    class HauntedWasteland
      def self.day08
        map = File.open('input/day08.txt') { |file| new file }
        puts "Day  8, Part One: #{ map.part_one_directions } steps are required to reach ZZZ."
        puts "Day  8, Part Two: #{ map.part_two_directions } steps are required to simultaneously reach all end-nodes."
        puts
      end

      # AAA = (BBB, CCC)
      PAT = /(\w\w\w) = \((\w\w\w), (\w\w\w)\)/

      def initialize(file)
        lines         = file.readlines(chomp: true)
        @instructions = lines.first.chars.map { _1 == 'L' ? 0 : 1 }
        @nodes        = lines[2..].to_h { |line| PAT.match(line) && [$1&.to_sym, [$2&.to_sym, $3&.to_sym]] }
        # pp self
      end

      def part_one_directions = follow_directions(:AAA, Set[:ZZZ])

      def follow_directions(node, end_nodes)
        # puts "Finding num steps from #{ node } to #{ end_nodes }."
        steps    = 0
        inst_len = @instructions.length
        until end_nodes.member?(node)
          node  = @nodes[node][@instructions[steps % inst_len]]
          steps += 1
        end
        # puts "Found #{ steps } steps to #{ node }."
        steps
      end

      # :reek:DuplicateMethodCall { max_calls: 2 }
      def part_two_directions
        keys        = @nodes.keys
        start_nodes = keys.select { _1.end_with?(?A) }
        end_nodes   = keys.select { _1.end_with?(?Z) }.to_set
        start_nodes.map { |node|
          # print "#{ node } -> any Z node: "
          follow_directions(node, end_nodes)
        }.reduce(&:lcm)
      end
    end
  end
end
