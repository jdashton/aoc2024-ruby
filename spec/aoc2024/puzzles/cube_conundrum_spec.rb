# frozen_string_literal: true

RSpec.describe AoC2024::Puzzles::CubeConundrum do
  context 'with provided test data' do
    subject(:cube_games) { described_class.new StringIO.new(<<~DATA) }
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    DATA

    it 'finds 8 as the sum of the possible game IDs' do
      expect(cube_games.possible_games_ids_sum).to eq 8
    end

    it 'finds 2286 as the sum of powers of minimal game cube sets' do
      expect(cube_games.minimal_powers).to eq 2286
    end
  end

  context 'with actual input data' do
    subject(:cube_games) { File.open('input/day02.txt') { |file| described_class.new file } }

    it 'finds 2,278 as the sum of the possible game IDs' do
      expect(cube_games.possible_games_ids_sum).to eq 2_278
    end

    it 'finds 67,953 as the power sum of the least possible cube sets' do
      expect(cube_games.minimal_powers).to eq 67_953
    end
  end
end
