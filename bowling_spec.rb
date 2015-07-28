require "./score_keeper"

describe ScoreKeeper do
  describe "calculating score" do
    let(:score_keeper) { described_class.new }

    context "when rolls are valid" do
      {
        "xxxxxxxxxxxx"          => 300,
        "--------------------"  => 0,
        "9-9-9-9-9-9-9-9-9-9-"  => 90,
        "5/5/5/5/5/5/5/5/5/5/5" => 150,
        "14456/5/---17/6/--2/6" => 82,
        "9/3561368153258-7181"  => 86,
        "9-3/613/815/0/8-7/8-"  => 121,
        "x3/61xxx2/9-7/xxx"     => 193
      }.each do |bowling_stats, score|

        it "returns #{score} for #{bowling_stats}" do
          expect(score_keeper.calculate(bowling_stats)).to eq score
        end

      end
    end

     context "when rolls are invalid" do
       [
         "9/3561368153258-718/",
         "9-3/613/815/0/8-7/88",
         "xx9"
       ].each do |bowling_stats|

         it "raises error for #{bowling_stats}" do
           expect {
             score_keeper.calculate(bowling_stats)
           }.to raise_error
         end

       end
     end
  end
end