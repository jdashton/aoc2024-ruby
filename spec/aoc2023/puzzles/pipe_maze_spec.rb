# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::PipeMaze do
  # noinspection SpellCheckingInspection
  context 'with provided test data 1' do
    subject(:sketch) { described_class.new StringIO.new(<<~DATA) }
      -L|F7
      7S-7|
      L|7||
      -L-J|
      L|-JF
    DATA

    it 'finds 4 as the number of steps to the farthest point' do
      expect(sketch.find_antipode).to eq 4
    end
  end

  # noinspection SpellCheckingInspection
  context 'with additional provided test data' do
    subject(:sketch) { described_class.new StringIO.new(<<~DATA) }
      7-F7-
      .FJ|7
      SJLL7
      |F--J
      LJ.LJ
    DATA

    it 'finds 8 as the number of steps to the farthest point' do
      expect(sketch.find_antipode).to eq 8
    end
  end

  context 'with actual input data' do
    subject(:sketch) { File.open('input/day10.txt') { |file| described_class.new file } }

    it 'finds 6,951 as the number of steps from start to antipode' do
      expect(sketch.find_antipode).to eq 6_951
    end

    #   it 'finds 13,524,038,372,771 as the number of steps from all start nodes to all end nodes' do
    #     expect(sketch.part_two_directions).to eq 13_524_038_372_771
    #   end
  end
end
