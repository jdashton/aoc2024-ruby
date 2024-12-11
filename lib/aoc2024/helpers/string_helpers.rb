# frozen_string_literal: true

module AoC2024
  # Helpers for Strings
  module StringHelpers
    refine String do
      def first_half = self[0, length / 2]

      def last_half = self[length / 2, length].to_i.to_s
    end
  end
end
