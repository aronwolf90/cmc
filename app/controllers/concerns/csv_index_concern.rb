# frozen_string_literal: true

module CsvIndexConcern
protected

  def csv_index
    result = run namespace::IndexCsvOperation
    export_collection = result[:model]
    send_data csv_exporter(export_collection).(export_collection)
  end

  def csv_exporter(collection)
    "#{namespace}CsvExporter".constantize
  end
end