# frozen_string_literal: true

require 'net/http'
require 'json'
require 'uri'

module Compliance
  class Request
    attr_accessor :request_body, :uri, :headers

    def initialize(request_body)
      @request_body = request_body
      @uri = URI.parse(CONFIG.api_url)
      @headers = {
        'Content-Type': 'text/json',
        'Authorization': "bearer #{CONFIG.api_token}"
      }
    end

    def call
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(@uri.request_uri, @headers)
      request.body = @request_body
      response = http.request(request)
      Response.new(response)
    end
  end
end
