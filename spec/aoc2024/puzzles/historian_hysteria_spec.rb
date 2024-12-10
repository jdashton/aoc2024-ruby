# frozen_string_literal: true

RSpec.describe AoC2024::Puzzles::HistorianHysteria do
  context 'with provided test data' do
    subject(:significant_locations) { described_class.new StringIO.new(<<~DATA) }
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    DATA

    it 'finds 11 as is the total distance between your lists' do
      expect(significant_locations.sum_distances).to eq 11
    end

    it 'finds 31 as the similarity score' do
      expect(significant_locations.similarity_score).to eq 31
    end
  end

  context 'with actual input data' do
    subject(:significant_locations) { File.open('input/day01.txt') { |file| described_class.new file } }

    it 'finds 1,110,981 as the sum of the calibration values' do
      expect(significant_locations.sum_distances).to eq 1_110_981
    end

    it 'finds 24,869,388 as the similarity score' do
      expect(significant_locations.similarity_score).to eq 24_869_388
    end
  end
end
