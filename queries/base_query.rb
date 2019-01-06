# frozen_string_literal: true

module Compliance
  class Query
    attr_accessor :template, :values, :serializer

    def initialize(query_name, **kwargs)
      @template = File.join(CONFIG.queries_path, query_name)
      @values = kwargs
      @serializer = lookup_serializer(query_name)
    end

    def lookup_serializer(query_name)
      resourse_name = query_name.split('.').first.capitalize
      serializer_name = ['Compliance::', resourse_name, 'Serializer'].join
      Object.const_get(serializer_name)
    end

    def to_graphql
      query = File.read(@template)
      @values.each do |k, v|
        query = query.gsub!("{{#{k}}}", v.to_s)
      end
      query
    end

    def to_json
      { query: to_graphql }.to_json
    end

    def call
      response = Request.new(to_json).call
      if response.success?
        @serializer.new.call(response.body)
      elsif response.unauthorized?
        Compliance::UnauthSerializer.new.call(response.body)
      else
        Compliance::ErrorSerializer.new.call(response.body)
      end
    end
  end
end
