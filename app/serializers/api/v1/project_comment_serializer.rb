# frozen_string_literal: true

module Api
  module V1
    class ProjectCommentSerializer < ApplicationSerializer
      attributes :content

      belongs_to :project, serializer: ProjectSerializer
      belongs_to :user, serializer: UserSerializer
    end
  end
end
