# frozen_string_literal: true

require 'json'

module Compliance
  class UnauthSerializer < Serializer
    def wrap(error_text)
      {
        response: {
          error: error_text
        }
      }
    end

    def call(response_body)
      message = JSON.parse(response_body)['message']
      wrap(message)
    end
  end
end
