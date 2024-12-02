# frozen_string_literal: true

RSpec.describe AoC2024::Puzzles::LensLibrary do
  # noinspection SpellCheckingInspection
  context 'with provided test data' do
    subject(:initialization_sequence) { described_class.new StringIO.new(<<~DATA) }
      rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    DATA

    it 'finds 1320 as the sum of HASHes of the steps' do
      expect(initialization_sequence.hash_steps).to eq 1320
    end

    it 'finds 145 as the total focusing power' do
      expect(initialization_sequence.initialize_lenses).to eq 145
    end
  end

  context 'with actual input data' do
    subject(:initialization_sequence) { File.open('input/day15.txt') { |file| described_class.new file } }

    it 'finds 517_965 as the sum of HASHes of the steps' do
      expect(initialization_sequence.hash_steps).to eq 517_965
    end

    it 'finds 267,372 as the total focusing power' do
      expect(initialization_sequence.initialize_lenses).to eq 267_372
    end
  end
end
