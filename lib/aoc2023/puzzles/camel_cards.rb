# frozen_string_literal: true

module AoC2023
  module Puzzles
    # For Day 7, we're scoring hands in Camel Cards.
    class CamelCards
      def self.day07
        hands = File.open('input/day07.txt') { |file| CamelCards.new file }
        puts "Day  7, Part One: #{ hands.total_winnings } are the total winnings."
        puts "Day  7, Part Two: #{ hands.total_winnings_with_joker } are the new total winnings."
        puts
      end

      # noinspection SpellCheckingInspection
      RANKS = {
        '23456'.chars.tally.values.tally => ?1, # High card
        'A23A4'.chars.tally.values.tally => ?2, # One pair
        '23432'.chars.tally.values.tally => ?3, # Two pair
        'TTT98'.chars.tally.values.tally => ?4, # Three of a kind
        '23332'.chars.tally.values.tally => ?5, # Full house
        'AA8AA'.chars.tally.values.tally => ?6, # Four of a kind
        'AAAAA'.chars.tally.values.tally => ?7 # Five of a kind
      }.freeze

      def initialize(file)
        @lines = file.readlines(chomp: true)
        # noinspection SpellCheckingInspection
        @hands = @lines
                   .map(&:split)
                   .map { |hand| [hand[0], hand[1].to_i] }
      end

      def total_winnings
        # noinspection SpellCheckingInspection
        @hands
          .sort_by { |cards, _| "#{ CamelCards.rank(cards) }#{ cards.tr('TJQKA', 'abcde') }" }
          .zip(1..).sum { |hand, index| hand[1] * index }
      end

      def self.rank(cards)
        RANKS[cards.chars.tally.values.tally]
      end

      def total_winnings_with_joker
        # noinspection SpellCheckingInspection
        @hands
          .sort_by { |cards, _| "#{ CamelCards.rank_with_joker(cards) }#{ cards.tr('TJQKA', 'a1cde') }" }
          .zip(1..).sum { |hand, index| hand[1] * index }
      end

      def self.rank_with_joker(cards)
        (
          [rank(cards)] +
            unique_cards_without_joker(cards).map { |card| rank cards.tr(card, ?J) }
        ).max
      end

      def self.unique_cards_without_joker(cards)
        cards.chars.uniq.reject { _1 == ?J }
      end
    end
  end
end
