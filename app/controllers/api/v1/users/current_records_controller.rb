# frozen_string_literal: true

module Api::V1
  module Users
    class CurrentRecordsController < ApiController
      include StandartActions
      namespace Records
      model_class Record
      serializer Api::V1::RecordSerializer

      public :show

      private
        def model
          @model ||= current_user.current_record
        end
    end
  end
end
