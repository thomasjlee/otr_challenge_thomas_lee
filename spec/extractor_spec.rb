require_relative "../lib/extractor.rb"
include Extractor

RSpec.describe Extractor do
  describe "::extract" do
    let(:extracted) { [["a", "b", "c", "d", "1/1/1111"],
                      ["e", "f", "g", "h", "2/2/2222"]] }

    context "given a file with comma-delimited values" do
      it "returns a two-dimensional array of records" do
        file = "./spec/fixtures/comma_delimited.csv"
        expect(extract(file)).to eq extracted
      end
    end

    context "given a file with pipe-delimited values" do
      it "returns a two-dimensional array of records" do
        file = "./spec/fixtures/pipe_delimited.txt"
        expect(extract(file)).to eq extracted
      end
    end

    context "given a file with space-delimited values" do
      it "returns a two-dimensional array of records" do
        file = "./spec/fixtures/space_delimited.txt"
        expect(extract(file)).to eq extracted
      end
    end
  end

  describe "::detect_delimiter" do
    it "detects comma-delimited values" do
      expect(detect_delimiter("a,b,c")).to eq ","
    end

    it "detects pipe-delimited values" do
      expect(detect_delimiter("a|b|c")).to eq "|"
    end

    it "detects space-delimited values" do
      expect(detect_delimiter("a b c")).to eq "\s"
    end
  end
end
