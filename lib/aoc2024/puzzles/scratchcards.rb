# frozen_string_literal: true

module AoC2024
  module Puzzles
    # For Day 4, we're adding up scratchcard points.
    class Scratchcards
      def self.day04
        card_pile = File.open('input/day04.txt') { |file| Scratchcards.new file }
        puts "Day  4, Part One: The scratchcards are worth #{ card_pile.total_points } points in total."
        puts "Day  4, Part Two: You end up with a total of #{ card_pile.total_scratchcards } scratchcards."
        puts
      end

      def initialize(file)
        @lines = file.readlines(chomp: true)
        @cards = @lines.each_with_object([]) { |line, acc| acc[(card = Card.new(line)).card_num] = card }
      end

      # A single scratchcard
      class Card
        attr_reader :card_num, :winning_numbers, :quantity

        def initialize(line)
          card, nums       = line.split(':')
          @card_num        = /Card\s+(\d+)/.match(card)[1].to_i
          @winning_numbers = nums.split('|').map(&:split).map { Set.new _1 }.reduce(:&).size
          @quantity        = 1
        end

        def points
          @winning_numbers.zero? ? 0 : 2 ** (@winning_numbers - 1)
        end

        def here_are_more_cards(num)
          @quantity += num
        end

        def win_more_cards(collection)
          (1..@winning_numbers).each { |n| collection[@card_num + n].here_are_more_cards(@quantity) }
        end
      end

      def total_points
        @cards[1..].map(&:points).sum
      end

      def win_more_cards
        @cards[1..].each do |this_card|
          this_card.win_more_cards(@cards)
        end
      end

      def total_scratchcards
        win_more_cards
        @cards[1..].map(&:quantity).sum
      end
    end
  end
end
