# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 10, we're finding the antipode.
    class PipeMaze
      def self.day10
        sketch = File.open('input/day10.txt') { |file| new file }
        puts "Day  10, Part One: #{ sketch.find_antipode } steps along the loop to get from the starting position " \
               'to the point farthest from the starting position.'
        # puts "Day  10, Part Two: #{ $INSTANCE_NAME.total_winnings_with_joker } are the new total winnings."
        puts
      end

      def initialize(file)
        @lines   = file.readlines(chomp: true)
        @visited = Set.new
      end

      def find_start
        @lines.each_with_index do |line, y|
          line.chars.each_with_index do |char, x|
            return [x, y] if char == 'S'
          end
        end
      end

      NEIGHBOR_NORTH = Set[?F, ?7, ?|]
      NEIGHBOR_SOUTH = Set[?L, ?J, ?|]
      NEIGHBOR_WEST  = Set[?F, ?L, ?-]
      NEIGHBOR_EAST  = Set[?7, ?J, ?-]

      def find_connecting_neighbors(x, y)
        connectors = []
        connectors << [x, y - 1] if NEIGHBOR_NORTH.member?(north_neighbor(x, y))
        connectors << [x, y + 1] if NEIGHBOR_SOUTH.member?(south_neighbor(x, y))
        connectors << [x - 1, y] if NEIGHBOR_WEST.member?(west_neighbor(x, y))
        connectors << [x + 1, y] if NEIGHBOR_EAST.member?(east_neighbor(x, y))
        connectors
      end

      def find_new_neighbor((x, y))
        # noinspection RubyCaseWithoutElseBlockInspection
        case @lines[y][x]
          when ?F then [[x, y + 1], [x + 1, y]]
          when ?7 then [[x, y + 1], [x - 1, y]]
          when ?L then [[x + 1, y], [x, y - 1]]
          when ?J then [[x - 1, y], [x, y - 1]]
          when ?- then [[x + 1, y], [x - 1, y]]
          when ?| then [[x, y + 1], [x, y - 1]]
        end
      end

      def north_neighbor(x, y) = @lines[y - 1]&.[](x)

      def south_neighbor(x, y) = @lines[y + 1]&.[](x)

      def west_neighbor(x, y) = @lines[y]&.[](x - 1)

      def east_neighbor(x, y) = @lines[y]&.[](x + 1)

      def walk_pipe((node_a, node_b), steps)
        until node_a == node_b
          # print "#{ node_a.inspect } "
          # print "'#{ @lines[node_a[1]][node_a[0]] }' and "
          # print "#{ node_b.inspect } "
          # print "'#{ @lines[node_b[1]][node_b[0]] }' at "
          # puts "#{ steps } steps"

          steps += 1

          node_a, node_b = [node_a, node_b]
                             .map do |node|
            @visited << node
            find_new_neighbor(node)
              .then { |neighbors| neighbors.reject { @visited.member? _1 } }.first
          end
        end
        steps
      end

      # S-7
      # |.|
      # L-J
      def find_antipode
        # pp @lines

        # Steps:
        # 1. Find the starting point.
        # 2. Detect which neighbors connect to S.
        # 3. Walk both neighbors until they are at the same place.

        start_x, start_y = find_start
        # puts "Start at #{ start_x }, #{ start_y }"
        @visited << [start_x, start_y]
        find_connecting_neighbors(start_x, start_y)
          .then { walk_pipe(_1, 1) }
      end
    end
  end
end
