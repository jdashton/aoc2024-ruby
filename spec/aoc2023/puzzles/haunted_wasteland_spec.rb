# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::HauntedWasteland do
  # noinspection SpellCheckingInspection
  context 'with provided test data' do
    subject(:map) { described_class.new StringIO.new(<<~DATA) }
      RL

      AAA = (BBB, CCC)
      BBB = (DDD, EEE)
      CCC = (ZZZ, GGG)
      DDD = (DDD, DDD)
      EEE = (EEE, EEE)
      GGG = (GGG, GGG)
      ZZZ = (ZZZ, ZZZ)
    DATA

    it 'finds 2 as the number of steps from AAA to ZZZ' do
      expect(map.part_one_directions).to eq 2
    end

    # it 'finds 2 as the sum of the predicted previous terms' do
    #   expect(map.sum_of_previous_terms).to eq 2
    # end
  end

  # noinspection SpellCheckingInspection
  context 'with additional provided test data' do
    subject(:map) { described_class.new StringIO.new(<<~DATA) }
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
    DATA

    it 'finds 6 as the number of steps from AAA to ZZZ' do
      expect(map.part_one_directions).to eq 6
    end
  end

  # noinspection SpellCheckingInspection
  context 'with Part 2 provided test data' do
    subject(:map) { described_class.new StringIO.new(<<~DATA) }
      LR

      11A = (11B, XXX)
      11B = (XXX, 11Z)
      11Z = (11B, XXX)
      22A = (22B, XXX)
      22B = (22C, 22C)
      22C = (22Z, 22Z)
      22Z = (22B, 22B)
      XXX = (XXX, XXX)
    DATA

    it 'finds 6 as the number of steps from all start nodes to all end nodes' do
      expect(map.part_two_directions).to eq 6
    end
  end

  context 'testing reduce(&:lcm)' do
    let(:steps) { [19_667, 13_019, 21_883, 20_221, 11_911, 16_343] }

    it 'finds the same big number for every order of these inputs' do
      steps.permutation.each do |perm|
        # pp perm
        expect(perm.reduce(&:lcm)).to eq 13_524_038_372_771
      end
    end
  end

  context 'with actual input data' do
    subject(:map) { File.open('input/day08.txt') { |file| described_class.new file } }

    it 'finds 13,019 as the number of steps from AAA to ZZZ' do
      expect(map.part_one_directions).to eq 13_019
    end

    it 'finds 13,524,038,372,771 as the number of steps from all start nodes to all end nodes' do
      expect(map.part_two_directions).to eq 13_524_038_372_771
    end
  end
end
