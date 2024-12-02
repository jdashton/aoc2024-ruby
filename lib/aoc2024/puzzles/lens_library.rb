# frozen_string_literal: true

module AoC2024
  module Puzzles
    # For Day 15, we're hashing steps.
    class LensLibrary
      def self.day15
        initialization_sequence = File.open('input/day15.txt') { |file| new file }
        puts "Day  15, Part One: #{ initialization_sequence.hash_steps } are the total winnings."
        puts "Day  15, Part Two: #{ initialization_sequence.initialize_lenses } is the focusing power of the " \
               'resulting lens configuration.'
        puts
      end

      def initialize(file)
        @steps = file.readlines(chomp: true).first.split(?,)
      end

      def hash_one_step(step_str)
        # Determine the ASCII code for the current character of the string.
        # Increase the current value by the ASCII code you just determined.
        # Set the current value to itself multiplied by 17.
        # Set the current value to the remainder of dividing itself by 256.

        step_str.bytes.reduce(0) do |current_value, byte|
          current_value += byte
          current_value *= 17
          current_value % 256
        end
      end

      def hash_steps
        @steps.map { |step| hash_one_step step }.sum
      end

      def initialize_lenses
        @steps
          .each_with_object([]) { |step, boxes| adjust_lenses(step, boxes) }
          .then { |boxes| find_focusing_power boxes }
      end

      def adjust_lenses(step, boxes)
        label, op, strength = step.split(/\b/)
        this_box            = (boxes[hash_one_step label] ||= [])

        # noinspection RubyCaseWithoutElseBlockInspection
        case op
          when ?-
            this_box.reject! { |lens| lens[0] == label }
          when ?=
            this_box[this_box.index { |lens| lens[0] == label } || this_box.length] = [label, strength]
        end
      end

      def find_focusing_power(boxes)
        # The focusing power of a single lens is the result of multiplying together:
        #
        # One plus the box number of the lens in question.
        # The slot number of the lens within the box: 1 for the first lens, 2 for the second lens, and so on.
        # The focal length of the lens.
        boxes.map.with_index(1) { |box, box_number|
          next unless box

          box.map.with_index(1) { |lens, slot_number|
            box_number * slot_number * lens[1].to_i
          }.sum
        }.compact.sum
      end
    end
  end
end
