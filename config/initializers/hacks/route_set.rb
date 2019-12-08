module ActionDispatch::Routing
  class RouteSet
    alias_method :original_url_for, :url_for

    def url_for(options, *args)
      options[:host] = options[:host].call if options[:host].respond_to?(:call)
      original_url_for options, *args
    end
  end
end
