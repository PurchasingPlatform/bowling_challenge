require "./score_keeper"

describe ScoreKeeper do
  describe "calculating score" do
    let(:score_keeper) { described_class.new }

    {
      "xxxxxxxxxxxx"          => 300,
      "--------------------"  => 0,
      "9-9-9-9-9-9-9-9-9-9-"  => 90,
      "5/5/5/5/5/5/5/5/5/5/5" => 150,
      "14456/5/---17/6/--2/6" => 133,
      "9/3561368153258-7181"  => 82,
      "9-3/613/815/0/8-7/8-"  => 121,
      "x3/61xxx2/9-7/xxx"     => 193
    }.each do |bowling_stats, score|

      it "returns #{score} for #{bowling_stats}" do
        expect(score_keeper.calculate(bowling_stats)).to eq score
      end

    end
  end
end