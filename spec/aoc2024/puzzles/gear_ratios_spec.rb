# frozen_string_literal: true

RSpec.describe AoC2024::Puzzles::GearRatios do
  context 'with provided test data' do
    subject(:schematic) { described_class.new StringIO.new(<<~DATA) }
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    DATA

    it 'finds 4,361 as the sum of all of the part numbers in the engine schematic' do
      expect(schematic.part_numbers_sum).to eq 4_361
    end

    it 'finds 467,835 as the sum of all of the gear ratios in your engine schematic' do
      expect(schematic.gear_ratios_sum).to eq 467_835
    end
  end

  context 'with actual input data' do
    subject(:schematic) { File.open('input/day03.txt') { |file| described_class.new file } }

    # 565,783 is too high: we're double-counting some tags.
    # 548,128 is also too high.
    # 546,349 is also too high.
    # 539,674 is not the right answer.
    it 'finds 540,212 as the sum of all of the part numbers in the engine schematic' do
      expect(schematic.part_numbers_sum).to eq 540_212
    end

    it 'finds 87,605,697 as the sum of all of the gear ratios in your engine schematic' do
      expect(schematic.gear_ratios_sum).to eq 87_605_697
    end
  end
end
