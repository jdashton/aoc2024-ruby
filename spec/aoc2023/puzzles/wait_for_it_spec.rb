# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::WaitForIt do
  context 'with provided test data' do
    subject(:boat_races) { described_class.new StringIO.new(<<~DATA) }
      Time:      7  15   30
      Distance:  9  40  200
    DATA

    it 'finds 288 as the lowest location' do
      expect(boat_races.race_ways).to eq 288
    end

    it 'finds 71,503 as the lowest location merged' do
      expect(boat_races.race_ways_merged).to eq 71_503
    end
  end

  context 'with actual input data' do
    subject(:boat_races) { File.open('input/day06.txt') { |file| described_class.new file } }

    it 'finds 2756160 as the lowest location' do
      expect(boat_races.race_ways).to eq 2_756_160
    end

    it 'finds 34,788,142 as the lowest location merged' do
      expect(boat_races.race_ways_merged).to eq 34_788_142
    end
  end
end
