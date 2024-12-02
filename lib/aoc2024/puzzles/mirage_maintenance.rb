# frozen_string_literal: true

module AoC2024
  module Puzzles
    # For Day 9, we're predicting sequence terms.
    class MirageMaintenance
      def self.day09
        sequences = File.open('input/day09.txt') { |file| new file }
        puts "Day  9, Part One: #{ sequences.sum_of_next_terms } is the sum of the predicted next terms."
        puts "Day  9, Part Two: #{ sequences.sum_of_previous_terms } is the sum of the predicted preceding terms."
        puts
      end

      def initialize(file)
        @lines      = file.readlines(chomp: true)
        @sequences  = @lines.map { |line| line.split.map(&:to_i) }
        @seq_layers = @sequences.map { |sequence| MirageMaintenance.make_layers(sequence) }
      end

      def self.make_layers(sequence)
        layers = [sequence]
        until (last_layer = layers.last)&.all?(&:zero?)
          layers << last_layer&.each_cons(2)&.map { |prev_term, next_term| next_term - prev_term }
        end
        layers
      end

      def self.next_term(layers)
        layers.last.append 0
        layers.reverse.each_cons(2) do |lower_layer, higher_layer|
          higher_layer.append(lower_layer.last + higher_layer.last)
        end

        layers.first&.last
      end

      def self.previous_term(layers)
        layers.last.prepend 0
        layers.reverse.each_cons(2) do |lower_layer, higher_layer|
          higher_layer.prepend(higher_layer.first - lower_layer.first)
        end

        layers.first&.first
      end

      def sum_of_next_terms
        @seq_layers.map { |layers| MirageMaintenance.next_term(layers) }.sum
      end

      def sum_of_previous_terms
        @seq_layers.map { |layers| MirageMaintenance.previous_term(layers) }.sum
      end
    end
  end
end
