# frozen_string_literal: true

module Api
  module V1
    class ContactAvatarsController < ApiController
      include StandartActions
      model_class ContactAvatar
      namespace ::Api::V1::ContactAvatars

      public :create

      def show
        send_file(
          path,
          disposition: :inline
        )
      end

    private
      def path
        model_class.find_by(id: params[:id])&.file&.path ||
          Rails.root.join("public", "avatar_placeholder.png")
      end
    end
  end
end
