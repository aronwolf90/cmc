# frozen_string_literal: true

class BaseCsvExporter
  include LpCSVExportable::CanExportAsCSV

  def self.call(collection)
    new.tap do |exporter|
      exporter.collection = collection
    end.to_csv
  end
end
