# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::Scratchcards do
  context 'with provided test data' do
    subject(:card_pile) { described_class.new StringIO.new(<<~DATA) }
      Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
      Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
      Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
      Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
      Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
      Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    DATA

    it 'finds 13 points as the total worth' do
      expect(card_pile.total_points).to eq 13
    end

    it 'finds 30 as the total number of scratchcards you end up with' do
      expect(card_pile.total_scratchcards).to eq 30
    end
  end

  context 'with actual input data' do
    subject(:card_pile) { File.open('input/day04.txt') { |file| described_class.new file } }

    it 'finds 24,706 points as the total worth' do
      expect(card_pile.total_points).to eq 24_706
    end

    it 'finds 13,114,317 as the total number of scratchcards you end up with' do
      expect(card_pile.total_scratchcards).to eq 13_114_317
    end
  end
end
