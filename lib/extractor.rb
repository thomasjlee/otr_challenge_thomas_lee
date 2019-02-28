module Extractor
  def extract(file)
    records = []
    File.open(file) do |f|
      f.each_line do |line|
        records << line.chomp.split(detect_delimiter(line))
      end
    end
    records
  end

  def detect_delimiter(line)
    delimiter_index = /,|\s|\|/ =~ line
    line[delimiter_index]
  end
end
