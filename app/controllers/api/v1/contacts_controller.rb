# frozen_string_literal: true

module Api
  module V1
    class ContactsController < ApiController
      include StandartActions
      namespace ::Api::V1::Contacts
      model_class Contact
      serializer ContactSerializer

      public :index, :show, :create, :update, :destroy
    end
  end
end
