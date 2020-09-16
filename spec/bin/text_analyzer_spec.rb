RSpec.describe "bin/text_analyzer" do
  it "accepts arguments as a list of one or more file paths" do
    out = %x[DEBUG=true bin/text_analyzer file1.txt file2.txt]
    expect(out).to match("[DEBUG] Processing file1.txt")
    expect(out).to match("[DEBUG] Processing file2.txt")
  end

  it "accepts input on stdin" do
    expect(%x[echo "yes hi hello" | DEBUG=true bin/text_analyzer]).to match("[DEBUG] Processing from STDIN")
  end

  it "displays help text if no input is provided" do
    expect(%x[bin/text_analyzer]).to match("Usage:")
  end

  it "displays help text if passed args that are not filenames" do
    expect(%x[bin/text_analyzer --textual-healing]).to match("Usage:")
    expect(%x[bin/text_analyzer fhqwhgads]).to match("Usage:")
  end
end
