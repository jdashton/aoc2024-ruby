# frozen_string_literal: true

RSpec.describe AoC2024::Puzzles::PlutonianPebbles do
  context 'with provided short test data' do
    subject(:pebbles) { described_class.new StringIO.new(<<~DATA) }
      0 1 10 99 999
    DATA

    it 'finds 7 as the number of stones after 1 blink' do
      expect(pebbles.blink(1)).to eq 7
    end
  end

  context 'with provided longer test data' do
    subject(:pebbles) { described_class.new StringIO.new(<<~DATA) }
      125 17
    DATA

    it 'finds 3 as the number of stones after 1 blink' do
      expect(pebbles.blink(1)).to eq 3
    end

    it 'finds 4 as the number of stones after 2 blinks' do
      expect(pebbles.blink(2)).to eq 4
    end

    it 'finds 5 as the number of stones after 3 blinks' do
      expect(pebbles.blink(3)).to eq 5
    end

    it 'finds 9 as the number of stones after 4 blinks' do
      expect(pebbles.blink(4)).to eq 9
    end

    it 'finds 13 as the number of stones after 5 blinks' do
      expect(pebbles.blink(5)).to eq 13
    end

    it 'finds 22 as the number of stones after 6 blinks' do
      expect(pebbles.blink(6)).to eq 22
    end

    it 'finds 55,312 as the number of stones after 25 blinks' do
      expect(pebbles.blink(25)).to eq 55_312
    end
  end

  context 'with actual input data' do
    subject(:pebbles) { File.open('input/day11.txt') { |file| described_class.new file } }

    it 'finds 231,278 as the number of stones after 25 blinks' do
      expect(pebbles.blink(25)).to eq 231_278
    end

    it 'finds 274,229,228,071,551 as the number of stones after 75 blinks' do
      expect(pebbles.blink(75)).to eq 274_229_228_071_551
    end
  end
end
