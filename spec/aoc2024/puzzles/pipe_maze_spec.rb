# frozen_string_literal: true

RSpec.describe AoC2024::Puzzles::PipeMaze do
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

    it 'finds 563 as the number of steps from start to antipode' do
      expect(sketch.find_points_in_loop).to eq 563
    end
  end

  # noinspection SpellCheckingInspection
  context 'with Part 2 first example' do
    subject(:sketch) { described_class.new StringIO.new(<<~DATA) }
      ...........
      .S-------7.
      .|F-----7|.
      .||.....||.
      .||.....||.
      .|L-7.F-J|.
      .|..|.|..|.
      .L--J.L--J.
      ...........
    DATA

    it 'finds 4 as the number of points inside the loop' do
      expect(sketch.find_points_in_loop).to eq 4
    end
  end

  # noinspection SpellCheckingInspection
  context 'with Part 2 second example' do
    subject(:sketch) { described_class.new StringIO.new(<<~DATA) }
      ..........
      .S------7.
      .|F----7|.
      .||OOOO||.
      .||OOOO||.
      .|L-7F-J|.
      .|II||II|.
      .L--JL--J.
      ..........
    DATA

    it 'finds 4 as the number of points inside the loop' do
      expect(sketch.find_points_in_loop).to eq 4
    end
  end

  # noinspection SpellCheckingInspection
  context 'with Part 2 third example' do
    subject(:sketch) { described_class.new StringIO.new(<<~DATA) }
      .F----7F7F7F7F-7....
      .|F--7||||||||FJ....
      .||.FJ||||||||L7....
      FJL7L7LJLJ||LJ.L-7..
      L--J.L7...LJS7F-7L7.
      ....F-J..F7FJ|L7L7L7
      ....L7.F7||L7|.L7L7|
      .....|FJLJ|FJ|F7|.LJ
      ....FJL-7.||.||||...
      ....L---J.LJ.LJLJ...
    DATA

    it 'finds 8 as the number of points inside the loop' do
      expect(sketch.find_points_in_loop).to eq 8
    end
  end

  # noinspection SpellCheckingInspection
  context 'with Part 2 fourth example' do
    subject(:sketch) { described_class.new StringIO.new(<<~DATA) }
      FF7FSF7F7F7F7F7F---7
      L|LJ||||||||||||F--J
      FL-7LJLJ||||||LJL-77
      F--JF--7||LJLJ7F7FJ-
      L---JF-JLJ.||-FJLJJ7
      |F|F-JF---7F7-L7L|7|
      |FFJF7L7F-JF7|JL---7
      7-L-JL7||F7|L7F-7F7|
      L.L7LFJ|||||FJL7||LJ
      L7JLJL-JLJLJL--JLJ.L
    DATA

    it 'finds 10 as the number of points inside the loop' do
      expect(sketch.find_points_in_loop).to eq 10
    end
  end
end
