# frozen_string_literal: true

module Hack
  module KnockDevise
    module Authenticable
      extend ActiveSupport::Concern

      included do
        before_action :skip_session, if: :token
      end

      # JWT: Knock defines it's own current_user method unless one is already
      # defined. As controller class is cached between requests, this method
      # stays and interferes with a browser-originated requests which rely on
      # Devise's implementation of current_user. As we define the method here,
      # Knock does not reimplement it anymore but we have to do its thing
      # manually.
      def current_user
        if token
          @_current_user ||=
            Knock::AuthToken.new(token: token).entity_for(User) rescue nil
        else
          super
        end
      end

      def authenticate!
        if token
          authenticate_user #  knock
        else
          authenticate_user! # devise
        end
      end

    private

      # JWT: No need to try and load session as there is none in an API request
      def skip_session
        request.session_options[:skip] = true
      end

      # JWT: overriding Knock's method to manually trigger Devise's auth.
      # When there is no token we assume the request comes from the browser so
      # has a session (potentially with warden key) attached.
      def authenticate_entity(entity_name)
        if token
          super(entity_name)
        else
          current_user
        end
      end
    end
  end
end
