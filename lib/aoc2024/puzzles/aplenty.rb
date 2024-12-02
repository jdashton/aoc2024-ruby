# frozen_string_literal: true

# require 'pp'

module AoC2024
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
        flow_lines, part_lines = file.readlines(chomp: true).slice_before(/^\s*$/).to_a
        @workflows             = parse_workflows(flow_lines)
        @parts                 = parse_parts(part_lines[1..])
      end

      def parse_parts(part_lines)
        part_lines.map do |part_line|
          /\{(?<attributes>.+)}/ =~ part_line
          attributes.split(',').to_h { |attribute| attribute.split('=').then { |k, v| [k.to_sym, v.to_i] } }
        end
      end

      def parse_workflows(flow_lines)
        flow_lines.to_h { |flow_line|
          /(?<name>\w+)\{(?<conditions>.+)}/ =~ flow_line
          [name.to_sym, conditions.split(',').map(&method(:parse_condition))]
        }.merge({ A: [:A], R: [:R] })
      end

      def parse_condition(clause)
        if /(?<attribute>\w+)(?<operator>[<>])(?<value>\d+):(?<result>\w+)/ =~ clause
          [attribute.to_sym, operator.to_sym, value.to_i, result.to_sym]
        else
          [clause.to_sym]
        end
      end

      def evaluate_part(part, rule = :in)
        @workflows[rule].each do |attribute, operator, value, result|
          # noinspection RubyCaseWithoutElseBlockInspection
          case operator
            when nil then return nil_int_workflow(attribute, part)

            when :<, :>
              return evaluate_part(part, result) if part[attribute].send(operator, value)
          end
        end
      end

      def nil_int_workflow(attribute, part)
        case attribute
          when :A then part.values.sum
          when :R then 0
          else
            evaluate_part(part, attribute)
        end
      end

      def split_fragment(fragment, attribute, value, operator = :>)
        value += 1 if operator == :>

        # puts "Splitting fragment #{ fragment } on attribute #{ attribute } with value #{ value }"
        # Possible cases:
        #     (10..100) > 200 ->  [nil, (10..100)]
        #     (10..100) > 100 ->  [nil, (10..100)]
        #     (10..100) > 5   ->  [(10..100), nil]
        #     (10..100) > 10  ->  [(11..100), (10..10)]
        #     (10..100) > 50  ->  [(51..100), (10..50)]
        return [nil, fragment] if fragment[attribute].end < value
        return [fragment, nil] if fragment[attribute].begin >= value

        new_frag_matching  = fragment.dup
        new_frag_differing = fragment.dup

        new_frag_matching[attribute], new_frag_differing[attribute] = partition_range(fragment, attribute, value, operator)

        [new_frag_matching, new_frag_differing]
      end

      def partition_range(fragment, attribute, value, operator = :<)
        [fragment[attribute].begin..(value - 1), value..fragment[attribute].end]
          .then { |partitions| operator == :< ? partitions : partitions.reverse }
      end

      def follow_rules(rule, space_fragment)
        @workflows[rule].map { |attribute, operator, value, result|
          # noinspection RubyCaseWithoutElseBlockInspection
          case operator
            when nil then nil_range_workflow(attribute, space_fragment)
            when :<, :>
              # Do two things:
              # 1. Modify the part that we're holding so that it contains the partial range that did not meet this rule
              #    and create a copy with the partial range that /does/ meet this rule.
              # 2. Send the copy into this rule.
              new_fragment, space_fragment = split_fragment(space_fragment, attribute, value, operator)
              new_fragment.nil? ? 0 : follow_rules(result, new_fragment)
          end
        }.sum
      end

      def nil_range_workflow(attribute, space_fragment)
        case attribute
          when :A then space_fragment.values.map(&:count).reduce(:*)
          when :R then 0
          else
            follow_rules(attribute, space_fragment)
        end
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

        follow_rules(:in, FULL_RANGE)
      end
    end
  end
end
