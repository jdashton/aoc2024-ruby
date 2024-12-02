# frozen_string_literal: true

RSpec.describe AoC2024::Puzzles::PointOfIncidence do
  # noinspection SpellCheckingInspection
  context 'with provided test data' do
    subject(:mirror_map) { described_class.new StringIO.new(<<~DATA) }
      #.##..##.
      ..#.##.#.
      ##......#
      ##......#
      ..#.##.#.
      ..##..##.
      #.#.##.#.

      #...##..#
      #....#..#
      ..##..###
      #####.##.
      #####.##.
      ..##..###
      #....#..#
    DATA

    it 'finds 405 as the summary of my notes' do
      expect(mirror_map.find_reflections).to eq 405
    end
  end

  context 'with actual input data' do
    subject(:mirror_map) { File.open('input/day13.txt') { |file| described_class.new file } }

    it 'finds 36,015 as the summary of my notes' do
      expect(mirror_map.find_reflections).to eq 36_015
    end
  end
end
