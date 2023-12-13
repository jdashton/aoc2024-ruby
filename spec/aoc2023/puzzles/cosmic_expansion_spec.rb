# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::CosmicExpansion do
  # noinspection SpellCheckingInspection
  context 'with provided test data' do
    subject(:sketch) { described_class.new StringIO.new(<<~DATA) }
      ...#......
      .......#..
      #.........
      ..........
      ......#...
      .#........
      .........#
      ..........
      .......#..
      #...#.....
    DATA

    it 'finds 374 as the sum of the shortest paths in the expanded universe' do
      expect(sketch.find_shortest_paths_sum).to eq 374
    end
  end

  context 'with actual input data' do
    subject(:sketch) { File.open('input/day11.txt') { |file| described_class.new file } }

    it 'finds 10,292,708 as the sum of the shortest paths in the expanded universe' do
      expect(sketch.find_shortest_paths_sum).to eq 10_292_708
    end
  end
end
