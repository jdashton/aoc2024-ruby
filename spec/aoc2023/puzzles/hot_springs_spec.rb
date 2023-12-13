# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::HotSprings do
  # noinspection SpellCheckingInspection
  context 'with provided test data' do
    subject(:report) { described_class.new StringIO.new(<<~DATA) }
      ???.### 1,1,3
      .??..??...?##. 1,1,3
      ?#?#?#?#?#?#?#? 1,3,1,6
      ????.#...#... 4,1,1
      ????.######..#####. 1,6,5
      ?###???????? 3,2,1
    DATA

    it 'finds 21 as the sum of possible arrangements' do
      expect(report.find_arrangements).to eq 21
    end
  end

  describe '#find_arrangements_for' do
    subject(:report) { described_class.new StringIO.new(<<~DATA) }
      ???.### 1,1,3
    DATA

    # rubocop:disable RSpec/ExampleLength
    it 'finds the expected number of arrangements for a given pattern', :aggregate_failures do
      expect(report.find_arrangements_for('???.### 1,1,3')).to eq 1
      expect(report.find_arrangements_for('.??..??...?##. 1,1,3')).to eq 4
      expect(report.find_arrangements_for('?#?#?#?#?#?#?#? 1,3,1,6')).to eq 1
      expect(report.find_arrangements_for('????.#...#... 4,1,1')).to eq 1
      expect(report.find_arrangements_for('????.######..#####. 1,6,5')).to eq 4
      expect(report.find_arrangements_for('?###???????? 3,2,1')).to eq 10
    end
  end
  # rubocop:enable RSpec/ExampleLength

  context 'with actual input data' do
    subject(:report) { File.open('input/day12.txt') { |file| described_class.new file } }

    it 'finds 6827 as the sum of possible arrangements' do
      expect(report.find_arrangements).to eq 6827
    end
  end
end
