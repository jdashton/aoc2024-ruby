# frozen_string_literal: true

RSpec.describe AoC2024::Puzzles::CosmicExpansion do
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

    it 'finds 1,030 as the sum of the shortest paths in the expanded universe' do
      expect(sketch.find_shortest_paths_sum(10)).to eq 1_030
    end

    it 'finds 8,410 as the sum of the shortest paths in the expanded universe' do
      expect(sketch.find_shortest_paths_sum(100)).to eq 8_410
    end
  end

  context 'with actual input data' do
    subject(:sketch) { File.open('input/day11.txt') { |file| described_class.new file } }

    it 'finds 10,292,708 as the sum of the shortest paths in the expanded universe' do
      expect(sketch.find_shortest_paths_sum).to eq 10_292_708
    end

    it 'finds 790,194,712,336 as the sum of the shortest paths in the expanded universe' do
      expect(sketch.find_shortest_paths_sum(1_000_000)).to eq 790_194_712_336
    end
  end
end
