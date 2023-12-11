# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::MirageMaintenance do
  # noinspection SpellCheckingInspection
  context 'with provided test data' do
    subject(:sequences) { described_class.new StringIO.new(<<~DATA) }
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
    DATA

    it 'finds 114 as the sum of the predicted next terms' do
      expect(sequences.sum_of_next_terms).to eq 114
    end

    it 'finds 2 as the sum of the predicted previous terms' do
      expect(sequences.sum_of_previous_terms).to eq 2
    end
  end

  context 'with actual input data' do
    subject(:sequences) { File.open('input/day09.txt') { |file| described_class.new file } }

    # 1584769178 is too high
    it 'finds 1,584,748,274 as the sum of the predicted next terms' do
      expect(sequences.sum_of_next_terms).to eq 1_584_748_274
    end

    it 'finds 1,026 as the sum of the predicted previous terms' do
      expect(sequences.sum_of_previous_terms).to eq 1_026
    end
  end
end
