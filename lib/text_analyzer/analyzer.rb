module TextAnalyzer
  class Analyzer
    attr_accessor :input

    def initialize(input)
      @input = input
    end

    def run
      if input == STDIN
        analyze(input)
      else
        # thread it
      end
    end
  end
end
