# frozen_string_literal: true

ONE_CYCLE = <<~DATA.chomp
  .....#....
  ....#...O#
  ...OO##...
  .OO#......
  .....OOO#.
  .O#...O#.#
  ....O#....
  ......OOOO
  #...O###..
  #..OO#....
DATA

TWO_CYCLES = <<~DATA.chomp
  .....#....
  ....#...O#
  .....##...
  ..O#......
  .....OOO#.
  .O#...O#.#
  ....O#...O
  .......OOO
  #..OO###..
  #.OOO#...O
DATA

THREE_CYCLES = <<~DATA.chomp
  .....#....
  ....#...O#
  .....##...
  ..O#......
  .....OOO#.
  .O#...O#.#
  ....O#...O
  .......OOO
  #...O###.O
  #.OOO#...O
DATA

RSpec.describe AoC2024::Puzzles::ParabolicReflectorDish do
  # noinspection SpellCheckingInspection
  context 'with provided test data' do
    subject(:mirror_map) { described_class.new StringIO.new(<<~DATA) }
      O....#....
      O.OO#....#
      .....##...
      OO.#O....O
      .O.....O#.
      O.#..O.#.#
      ..O..#O..O
      .......O..
      #....###..
      #OO..#....
    DATA

    it 'finds 136 as the total load on the north support beams' do
      expect(mirror_map.total_load_on_beams).to eq 136
    end

    it 'finds the expect configuration after 1 cycle' do
      expect(mirror_map.cycle(1).map(&:join).join("\n")).to eq(ONE_CYCLE)
    end

    it 'finds the expect configuration after 2 cycles' do
      expect(mirror_map.cycle(2).map(&:join).join("\n")).to eq(TWO_CYCLES)
    end

    it 'finds the expect configuration after 3 cycles' do
      expect(mirror_map.cycle(3).map(&:join).join("\n")).to eq(THREE_CYCLES)
    end

    it 'finds 64 as the total load on the north support beams after ONE BILLION cycles' do
      expect(mirror_map.total_load_on_beams_after_billion).to eq 64
    end
  end

  context 'with actual input data' do
    subject(:mirror_map) { File.open('input/day14.txt') { |file| described_class.new file } }

    it 'finds 109,596 as the total load on the north support beams' do
      expect(mirror_map.total_load_on_beams).to eq 109_596
    end

    it 'finds 96,105 as the total load on the north support beams after ONE BILLION cycles' do
      expect(mirror_map.total_load_on_beams_after_billion).to eq 96_105
    end
  end
end
