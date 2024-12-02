# frozen_string_literal: true

RSpec.describe AoC2024::Puzzles::IfYouGiveASeedAFertilizer do
  context 'with provided test data' do
    subject(:card_pile) { described_class.new StringIO.new(<<~DATA) }
      seeds: 79 14 55 13

      seed-to-soil map:
      50 98 2
      52 50 48

      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15

      fertilizer-to-water map:
      49 53 8
      0 11 42
      42 0 7
      57 7 4

      water-to-light map:
      88 18 7
      18 25 70

      light-to-temperature map:
      45 77 23
      81 45 19
      68 64 13

      temperature-to-humidity map:
      0 69 1
      1 0 69

      humidity-to-location map:
      60 56 37
      56 93 4
    DATA

    it 'finds 35 as the lowest location' do
      expect(card_pile.lowest_location).to eq 35
    end

    it 'finds 46 as the lowest location for seeds in ranges' do
      expect(card_pile.lowest_location_with_seed_ranges).to eq 46
    end
  end

  context 'with actual input data' do
    subject(:card_pile) { File.open('input/day05.txt') { |file| described_class.new file } }

    it 'finds 662,197,086 as the lowest location' do
      expect(card_pile.lowest_location).to eq 662_197_086
    end

    # 102,613,525 is one of my intermediate answers, corresponding to the first range of seeds in the input file.
    # It is too high to be the correct answer. There's no point in checking any answers that are higher than this.
    # The second range of seeds found this as its lowest location: 566,602,517.
    # Checking range 1972667147..2378259164
    # 102613525
    # Checking range 1450194064..1477976315
    # 566602517
    # Checking range 348350443..410212616
    # 624704155
    # Checking range 3911195009..4092364214
    # 228214335
    # Checking range 626861593..765648079
    # 1048225358
    # Checking range 2886966111..3162265118
    # 52510809
    # Checking range 825403564..1303406954
    # 123535055
    # Checking range 514585599..520687689
    # 4153786415
    # Checking range 2526020300..2541511752
    # 2658982616
    # Checking range 3211013652..3757205390
    # 56651838
    # it 'finds 52,510,809 as the lowest location for seeds in ranges' do
    #   expect(card_pile.lowest_location_with_seed_ranges).to eq 52_510_809
    # end
  end
end
