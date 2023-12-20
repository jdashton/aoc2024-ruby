# frozen_string_literal: true

RSpec.describe AoC2023::Puzzles::Aplenty do
  # noinspection SpellCheckingInspection
  context 'with provided test data' do
    subject(:workflows) { described_class.new StringIO.new(<<~DATA) }
      px{a<2006:qkq,m>2090:A,rfg}
      pv{a>1716:R,A}
      lnx{m>1548:A,A}
      rfg{s<537:gd,x>2440:R,A}
      qs{s>3448:A,lnx}
      qkq{x<1416:A,crn}
      crn{x>2662:A,R}
      in{s<1351:px,qqz}
      qqz{s>2770:qs,m<1801:hdj,R}
      gd{a>3333:R,R}
      hdj{m>838:A,pv}

      {x=787,m=2655,a=1222,s=2876}
      {x=1679,m=44,a=2067,s=496}
      {x=2036,m=264,a=79,s=2244}
      {x=2461,m=1339,a=466,s=291}
      {x=2127,m=1623,a=2188,s=1013}
    DATA

    it 'finds 19,114 as the sum of attributes for the accepted parts' do
      expect(workflows.evaluate_parts).to eq 19_114
    end

    it 'finds 167,409,079,868,000 as distinct combinations of ratings that will be accepted by the Elves\' workflows' do
      expect(workflows.find_combinations).to eq 167_409_079_868_000
    end
  end

  context 'with actual input data' do
    subject(:workflows) { File.open('input/day19.txt') { |file| described_class.new file } }

    it 'finds 373,302 as the sum of attributes for the accepted parts' do
      expect(workflows.evaluate_parts).to eq 373_302
    end

    it 'finds 130,262,715,574,114 as distinct combinations of ratings that will be accepted by the Elves\' workflows' do
      expect(workflows.find_combinations).to eq 130_262_715_574_114
    end
  end
end
