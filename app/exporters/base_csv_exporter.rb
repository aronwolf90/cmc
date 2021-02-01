# frozen_string_literal: true

class BaseCsvExporter
  include LpCSVExportable::CanExportAsCSV

  def to_csv
    CSV.generate(nil, col_sep: ";", force_quotes: true) do |csv|
      csv << headers
      data_matrix.each do |row|
        csv << row
      end
    end
  end

  def self.call(collection)
    new.tap do |exporter|
      exporter.collection = collection
    end.to_csv
  end
end
