# frozen_string_literal: true

class MutationFinder
  attr_reader :_model, :_name

  def initialize(model, name)
    @_model = model
    @_name = name
  end

  def call
    lambda do |model: nil, **args|
      model ||= _model.is_a?(Class) ? _model.new : _model
      service_clazz.call(model: model, **args)
    end
  end

  private
    def service_clazz
      @service_clazz =
        if clazz.present?
          "#{clazz.name.pluralize}::#{camelized_name}Mutation"
        else
          "Standard#{camelized_name}Mutation"
        end.constantize
    end

    def clazz
      @clazz ||=
        model_clazz.ancestors.select(&:application_descendant?).find do |clazz|
          "#{clazz.name.pluralize}::#{camelized_name}Mutation".constantize
        rescue NameError
          false
        end
    end

    def model_clazz
      _model.is_a?(Class) ? _model : _model.class
    end

    def camelized_name
      _name.to_s.camelize
    end
end
