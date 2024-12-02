# frozen_string_literal: true

RSpec.describe AoC2024::Puzzles::Trebuchet do
  context 'with provided test data' do
    subject(:calibration_values) { described_class.new StringIO.new(<<~DATA) }
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    DATA

    it 'finds 142 as the sum of the calibration values' do
      expect(calibration_values.sum_numbers).to eq 142
    end
  end

  context 'with actual input data' do
    subject(:calibration_values) { File.open('input/day01.txt') { |file| described_class.new file } }

    it 'finds 54,632 as the sum of the calibration values' do
      expect(calibration_values.sum_numbers).to eq 54_632
    end

    it 'finds 54,019 as the sum of the calibration values with words' do
      expect(calibration_values.sum_with_words).to eq 54_019
    end
  end

  context 'with provided test data with words' do
    subject(:calibration_values) { described_class.new StringIO.new(<<~DATA) }
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
    DATA

    it 'finds 281 as the sum of the calibration values' do
      expect(calibration_values.sum_with_words).to eq 281
    end
  end
end
