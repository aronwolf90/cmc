# frozen_string_literal: true

Kaminari::Helpers::Paginator.class_eval do
  def render(&block)
    instance_eval(&block) if @options[:total_pages] > 1
    # @output_buffer
  end
end
