RSpec.describe TextAnalyzer do
  describe "::sort_order" do
    it "defaults to TextAnalyzer::DEFAULT_SORT_ORDER" do
      stub_const("TextAnalyzer::DEFAULT_SORT_ORDER", "ascending")
      allow(ENV).to receive(:[]).with("SORT_ORDER").and_return(nil)
      expect(TextAnalyzer.sort_order).to eq("ascending")
    end

    it "warns if an unrecognized option is provided" do
      stub_const("TextAnalyzer::DEFAULT_SORT_ORDER", "ascending")
      allow(ENV).to receive(:[]).with("SORT_ORDER").and_return("foo")
      expect(TextAnalyzer::LOGGER).to receive(:warn).with(/Unrecognized sort order/)
      expect(TextAnalyzer.sort_order).to eq("ascending")
    end

    it "accepts and returns known sort orders" do
      stub_const("TextAnalyzer::DEFAULT_SORT_ORDER", "foo")
      stub_const("TextAnalyzer::SORT_ORDERS", ["foo", "bar"])
      allow(ENV).to receive(:[]).with("SORT_ORDER").and_return("foo")
      expect(TextAnalyzer.sort_order).to eq("foo")
    end
  end
end
