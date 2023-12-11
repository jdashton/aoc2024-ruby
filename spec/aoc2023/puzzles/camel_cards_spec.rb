# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::CamelCards do
  # noinspection SpellCheckingInspection
  context 'with provided test data' do
    subject(:hands) { described_class.new StringIO.new(<<~DATA) }
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
    DATA

    it 'finds 6440 as the total winnings' do
      expect(hands.total_winnings).to eq 6440
    end

    it 'finds 5905 as the total winnings' do
      expect(hands.total_winnings_with_joker).to eq 5905
    end
  end

  context 'with actual input data' do
    subject(:hands) { File.open('input/day07.txt') { |file| described_class.new file } }

    it 'finds 248,105,065 as the total winnings' do
      expect(hands.total_winnings).to eq 248_105_065
    end

    it 'finds 249,515,436 as the total winnings' do
      expect(hands.total_winnings_with_joker).to eq 249_515_436
    end
  end
end
