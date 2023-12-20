# frozen_string_literal: true

require 'pp'

module AoC2023
  module Puzzles
    # For Day 19, we're running workflows.
    class Aplenty
      def self.day19
        workflows = File.open('input/day19.txt') { |file| new file }
        puts "Day  19, Part One: #{ workflows.evaluate_parts } is the number you get if you add together all of the rating " \
               'numbers for all of the parts that ultimately get accepted.'
        puts "Day  19, Part Two: #{ workflows.find_combinations } distinct combinations of ratings will be accepted " \
               "by the Elves' workflows."
        puts
      end

      def initialize(file)
        @decision_points = 0
        flows, parts = file.readlines(chomp: true).slice_before(/^\s*$/).to_a
        @workflows   = flows.to_h do |flow|
          /(?<name>\w+)\{(?<conditions>.+)}/ =~ flow
          [
            name.to_sym,
            conditions
              .split(',')
              .map { |clause|
                if /(?<attribute>\w+)(?<operator>[<>]=?)(?<value>\d+):(?<result>\w+)/ =~ clause
                  [attribute.to_sym, operator&.to_sym, value.to_i, result&.to_sym]
                else
                  [clause.to_sym]
                end }
          ]
        end.merge({ A: [:A], R: [:R] })

        @parts = parts[1..].map do |part|
          /\{(?<attributes>.+)}/ =~ part
          attributes.split(',').map { |attribute| attribute.split('=') }.map { |k, v| [k.to_sym, v.to_i] }.to_h
        end
      end

      def evaluate_part(part, rule = :in)
        @workflows[rule].each do |attribute, operator, value, result|
          if operator.nil?
            case attribute
              when :A then return part.values.sum
              when :R then return 0
              else
                return evaluate_part(part, attribute) # if @workflows[result].present?
            end
          end

          # puts "Rule #{ rule }, attribute: #{ attribute }, operator: #{ operator }, value: #{ value }, result: #{ result }"
          case operator
            when :<
              return evaluate_part(part, result) if part[attribute] < value
            when :>
              return evaluate_part(part, result) if part[attribute] > value
            else
              raise "Unexpected operator #{ operator }"
          end
        end
      end

      def split_fragment_less_than(fragment, attribute, value)
        # puts "Splitting fragment #{ fragment } on attribute #{ attribute } with value #{ value }"
        # Possible cases:
        #     (10..100) < 200 ->  [(10..100), nil]
        #     (10..100) < 5   ->  [nil, (10..100)]
        #     (10..100) < 10  ->  [nil, (10..100)]
        #     (10..100) < 100 ->  [(10..99), (100..100)]
        #     (10..100) < 50  ->  [(10..49), (50..100)]
        return [nil, fragment] if fragment[attribute].end < value
        return [fragment, nil] if fragment[attribute].begin >= value

        new_frag_left            = fragment.dup
        new_frag_left[attribute] = (fragment[attribute].begin..(value - 1))

        new_frag_right            = fragment.dup
        new_frag_right[attribute] = (value..fragment[attribute].end)
        [new_frag_left, new_frag_right]
      end

      def split_fragment_greater_than(fragment, attribute, value)
        # puts "Splitting fragment #{ fragment } on attribute #{ attribute } with value #{ value }"
        # Possible cases:
        #     (10..100) > 200 ->  [nil, (10..100)]
        #     (10..100) > 100 ->  [nil, (10..100)]
        #     (10..100) > 5   ->  [(10..100), nil]
        #     (10..100) > 10  ->  [(11..100), (10..10)]
        #     (10..100) > 50  ->  [(51..100), (10..50)]
        return [nil, fragment] if fragment[attribute].end <= value
        return [fragment, nil] if fragment[attribute].begin > value

        new_frag_left            = fragment.dup
        new_frag_left[attribute] = ((value + 1)..fragment[attribute].end)

        new_frag_right            = fragment.dup
        new_frag_right[attribute] = (fragment[attribute].begin..value)
        [new_frag_left, new_frag_right]
      end

      def follow_rules(rule, space_fragment)
        @workflows[rule].map { |attribute, operator, value, result|
          # puts "Rule #{ rule }, attribute: #{ attribute }, operator: #{ operator }, value: #{ value }, result: #{ result }"
          @decision_points += 1
          case operator
            when nil
              # puts " -- operator is nil, attribute is #{ attribute }, space_fragment is #{ space_fragment }"
              case attribute
                when :A
                  # puts " -- -- Accepted ranges are #{ space_fragment }"
                  # puts "       contributes #{ space_fragment.values.map(&:count).reduce(:*) }"
                  space_fragment.values.map(&:count).reduce(:*)
                when :R
                  # puts " -- -- Rejected ranges are #{ space_fragment }"
                  0
                else
                  # puts " -- -- Following rules at #{ attribute }"
                  follow_rules(attribute, space_fragment) # if @workflows[result]
              end
            when :<
              # Do two things:
              # 1. Modify the part that we're holding so that it contains the partial range that did not meet this rule
              #    and create a copy with the partial range that /does/ meet this rule.
              # 2. Send the copy into this rule.
              new_fragment, space_fragment = split_fragment_less_than(space_fragment, attribute, value)
              new_fragment.nil? ? 0 : follow_rules(result, new_fragment)
            when :>
              new_fragment, space_fragment = split_fragment_greater_than(space_fragment, attribute, value)
              new_fragment.nil? ? 0 : follow_rules(result, new_fragment)
            else
              raise "Unexpected operator #{ operator }"
          end
        }.sum
      end

      def evaluate_parts
        # PP.pp @workflows, $stdout, 80
        # PP.pp @parts, $stdout, 80

        @parts.map { |part| evaluate_part(part) }.sum
      end

      FULL_RANGE = {
        x: (1..4000),
        m: (1..4000),
        a: (1..4000),
        s: (1..4000)
      }.freeze

      def find_combinations
        # PP.pp @workflows, $stdout, 80
        # 167409079868000
        range_total = follow_rules(:in, FULL_RANGE)
        puts "Decision points: #{ @decision_points }"
        range_total
      end
    end
  end
end
