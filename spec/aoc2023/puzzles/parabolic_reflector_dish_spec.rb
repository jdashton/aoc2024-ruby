# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::ParabolicReflectorDish do
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
      pending('Implement this')
      expect(mirror_map.total_load_on_beams).to eq 136
    end
  end

  context 'with actual input data' do
    subject(:mirror_map) { File.open('input/day14.txt') { |file| described_class.new file } }

    it 'finds 136 as the total load on the north support beams' do
      pending('Implement this')
      expect(mirror_map.total_load_on_beams).to eq 136
    end
  end
end
