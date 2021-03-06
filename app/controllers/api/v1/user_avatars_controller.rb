# frozen_string_literal: true

module Api
  module V1
    class UserAvatarsController < ApiController
      include StandartActions
      model_class UserAvatar
      namespace ::Api::V1::UserAvatars
      serializer UserAvatarSerializer

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
