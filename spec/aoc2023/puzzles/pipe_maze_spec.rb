# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::PipeMaze do
  # noinspection SpellCheckingInspection
  context 'with provided test data 1' do
    subject(:sketch) { described_class.new StringIO.new(<<~DATA) }
      .....
      .S-7.
      .|.|.
      .L-J.
      .....
    DATA

    it 'finds 4 as the number of steps to the farthest point' do
      expect(sketch.find_antipode).to eq 4
    end
  end

  # noinspection SpellCheckingInspection
  context 'with additional provided test data' do
    subject(:sketch) { described_class.new StringIO.new(<<~DATA) }
      ..F7.
      .FJ|.
      SJ.L7
      |F--J
      LJ...
    DATA

    it 'finds 8 as the number of steps to the farthest point' do
      expect(sketch.find_antipode).to eq 8
    end
  end

  # context 'with actual input data' do
  #   subject(:sketch) { File.open('input/day08.txt') { |file| described_class.new file } }
  #
  #   it 'finds 13,019 as the number of steps from AAA to ZZZ' do
  #     expect(sketch.part_one_directions).to eq 13_019
  #   end
  #
  #   it 'finds 13,524,038,372,771 as the number of steps from all start nodes to all end nodes' do
  #     expect(sketch.part_two_directions).to eq 13_524_038_372_771
  #   end
  # end
end
