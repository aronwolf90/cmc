# frozen_string_literal: true

class MvcIndexParentModelStep < BaseIndexStep
  attr_reader :relation, :per

  def initialize(relation:, per: 15)
    @relation = relation
    @per = per
  end

  def call(options, parent:, params:, **)
    options["model"] =
      self.class.page(parent.public_send(relation), page: params[:page], per: per)
  end
end
