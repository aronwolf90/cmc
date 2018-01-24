module Api
  module V1
    class CommentForm < BaseForm
      associations []

      attributes :content
      validates :content, presence: true, if: ->{ params_contains?(:content) }
    end
  end
end
