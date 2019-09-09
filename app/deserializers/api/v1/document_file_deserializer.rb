# frozen_string_literal: true

module Api::V1
  class DocumentFileDeserializer
    def self.call(params)
      {
        file: params[:file],
        not_finished: params[:not_finished]
      }
    end
  end
end
