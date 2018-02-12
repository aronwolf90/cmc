module Api
  module V1
    class CommentsController < ApiController
      def create
        comment = issue.comments.build
        form = CommentForm.new(comment, params: issue_params)
        service = Comments::CreateService.new(comment, params: issue_params)

        if form.valid?
          service.perform

          render json: comment
        else
          render json: form.errors
        end
      end

      private

      def issue
        @issue ||= Issue.find(params[:issue_id])
      end

      def issue_params
        params.permit(
          [
            data: [
              attributes: %i[content]
            ]
          ]
        )
      end
    end
  end
end
