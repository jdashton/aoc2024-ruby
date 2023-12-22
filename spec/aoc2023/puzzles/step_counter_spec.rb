# frozen_string_literal: true

AFTER_ONE_STEP = <<~DATA.split("\n").map(&:chomp)
  ...........
  .....###.#.
  .###.##..#.
  ..#.#...#..
  ....#O#....
  .##.O.####.
  .##..#...#.
  .......##..
  .##.#.####.
  .##..##.##.
  ...........
DATA

AFTER_TWO_STEPS = <<~DATA.split("\n").map(&:chomp)
  ...........
  .....###.#.
  .###.##..#.
  ..#.#O..#..
  ....#.#....
  .##O.O####.
  .##.O#...#.
  .......##..
  .##.#.####.
  .##..##.##.
  ...........
DATA

AFTER_THREE_STEPS = <<~DATA.split("\n").map(&:chomp)
  ...........
  .....###.#.
  .###.##..#.
  ..#.#.O.#..
  ...O#O#....
  .##.O.####.
  .##O.#...#.
  ....O..##..
  .##.#.####.
  .##..##.##.
  ...........
DATA

AFTER_SIX_STEPS = <<~DATA.split("\n").map(&:chomp)
  ...........
  .....###.#.
  .###.##.O#.
  .O#O#O.O#..
  O.O.#.#.O..
  .##O.O####.
  .##.O#O..#.
  .O.O.O.##..
  .##.#.####.
  .##O.##.##.
  ...........
DATA

RSpec.describe AoC2023::Puzzles::StepCounter do
  # noinspection SpellCheckingInspection
  context 'with provided test data' do
    subject(:map) { described_class.new StringIO.new(<<~DATA) }
      ...........
      .....###.#.
      .###.##..#.
      ..#.#...#..
      ....#.#....
      .##..S####.
      .##..#...#.
      .......##..
      .##.#.####.
      .##..##.##.
      ...........
    DATA

    it 'finds 16 as the number of garden plots that could be reached in 6 steps' do
      expect(map.count_steps(6)).to eq 16
    end

    it 'finds the expected map after 1 step' do
      expect(map.take_steps(1)).to eq AFTER_ONE_STEP
    end

    it 'finds the expected map after 2 steps' do
      expect(map.take_steps(2)).to eq AFTER_TWO_STEPS
    end

    it 'finds the expected map after 3 steps' do
      expect(map.take_steps(3)).to eq AFTER_THREE_STEPS
    end

    it 'finds the expected map after 6 steps' do
      expect(map.take_steps(6)).to eq AFTER_SIX_STEPS
    end
  end

  context 'with actual input data' do
    subject(:map) { File.open('input/day21.txt') { |file| described_class.new file } }

    it 'finds 3,615 as the number of garden plots that could be reached in 6 steps' do
      expect(map.count_steps(64)).to eq 3_615
    end
  end
end
