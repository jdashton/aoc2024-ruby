# frozen_string_literal: true

module AoC2024
  # Helpers for formatting numbers.
  module NumberFormatting
    refine Integer do
      # Add commas to numbers for easier reading.
      def with_commas = to_s.gsub(/(\d)(?=(\d{3})+(?!\d))/, '\\1,')
    end
  end
end
