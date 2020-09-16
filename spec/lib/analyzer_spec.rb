RSpec.describe TextAnalyzer::Analyzer do
  let(:input) { instance_double(File) }
  let(:analyzer) { TextAnalyzer::Analyzer.new(input) }

  before(:each) { allow(input).to receive(:path).and_return("/some/file/path.txt") }

  describe "#run" do
    it "analyzes STDOUT without starting a new thread"
    it "analyzes a single file input without starting a new thread"
    it "analyzes each file in a new thread when given multiple input files"
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
  end

  describe "#normalize!" do
  end
end
