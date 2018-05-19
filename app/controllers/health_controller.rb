# frozen_string_literal: true

class HealthController < ApplicationController
  # TODO implement proper health checking based on your system requirements
  def index
    render json: { status: :ok }
  end
end
