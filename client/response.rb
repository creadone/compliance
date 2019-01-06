# frozen_string_literal: true

module Compliance
  class Response
    attr_accessor :http

    def initialize(http)
      @http = http
    end

    def success?
      @http.is_a?(Net::HTTPOK) && !JSON.parse(@http.body).key?('errors')
    end

    def unauthorized?
      @http.is_a?(Net::HTTPUnauthorized)
    end

    def body
      @http.body
    end
  end
end
