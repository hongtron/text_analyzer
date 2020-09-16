RSpec.describe TextAnalyzer::Analyzer do
  let(:input) { instance_double(File) }
  let(:analyzer) { TextAnalyzer::Analyzer.new(input) }

  before(:each) { allow(input).to receive(:path).and_return("/some/file/path.txt") }

  describe "#run" do
    it "analyzes STDOUT without starting a new thread"
    it "analyzes a single file input without starting a new thread"
    it "analyzes each file in a new thread when given multiple input files"
    it "returns the most common sequences of length SEQUENCE_SIZE in the input"
    it "correctly combines results from multiple input files"
  end

  describe "#analyze" do
    it "returns an empty result set if the input contains fewer than SEQUENCE_SIZE words" do
      stub_const("TextAnalyzer::Analyzer::SEQUENCE_SIZE", 4)
      allow(input).to receive(:each_line)
        .and_yield(generate_word)
        .and_yield(generate_word)
        .and_yield(generate_word)
      analyzer = TextAnalyzer::Analyzer.new(input)
      expect(analyzer.analyze(input).length).to eq(0)
    end

    it "detects sequences of SEQUENCE_SIZE words across multiple lines" do
      stub_const("TextAnalyzer::Analyzer::SEQUENCE_SIZE", 4)
      allow(input).to receive(:each_line)
        .and_yield(generate_word)
        .and_yield(generate_word)
        .and_yield(generate_word)
        .and_yield(generate_word)
      analyzer = TextAnalyzer::Analyzer.new(input)
      expect(analyzer.analyze(input).length).to eq(1)
    end

    it "detects sequences of SEQUENCE_SIZE words across empty lines" do
      stub_const("TextAnalyzer::Analyzer::SEQUENCE_SIZE", 3)
      allow(input).to receive(:each_line)
        .and_yield(generate_word)
        .and_yield("")
        .and_yield(generate_word)
        .and_yield(generate_word)
      analyzer = TextAnalyzer::Analyzer.new(input)
      expect(analyzer.analyze(input).length).to eq(1)
    end
  end

  describe "#normalize!" do
    it "ignores punctuation" do
      expect(analyzer.normalize!("(i love sandwiches!!!)")).to eq("i love sandwiches")
    end

    it "resolves upper and lower casing differences" do
      expect(analyzer.normalize!("I LOVE SANDWICHES")).to eq("i love sandwiches")
    end
  end

  describe "#get_most_common" do
    it "returns the top RANK_CUTOFF results keyed and ordered by count" do
      stub_const("TextAnalyzer::Analyzer::RANK_CUTOFF", 3)

      result = {
        ["we", "were", "both"] => 2,
        ["young", "when", "i"] => 5,
        ["first", "saw", "you"] => 1,
        ["i", "close", "my"] => 4,
        ["eyes", "the", "flashback"] => 7,
        ["starts", "im", "standin"] => 6,
      }

      top_3 = {
        7 => ["eyes", "the", "flashback"],
        6 => ["starts", "im", "standin"],
        5 => ["young", "when", "i"],
      }

      expect(analyzer.get_most_common(result)).to eq(top_3)
    end
  end

  describe "#display" do
    it "correctly formats the results and prints them to STDOUT"
  end
end
