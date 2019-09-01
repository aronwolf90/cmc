# frozen_string_literal: true

module Api
  module V1
    class ContactAvatarsController < ApiController
      include StandartActions
      model_class ContactAvatar
      namespace ::Api::V1::ContactAvatars

      public :create

      def show
        send_data(
          model.file.read,
          filename: File.basename(model.file.path),
          disposition: :inline
        )
      rescue ActiveRecord::RecordNotFound
        file = File.open(Rails.root.join("public", "avatar_placeholder.png"))
        send_file(
          file,
          disposition: :inline
        )
      end
    end
  end
end
