# frozen_string_literal: true
require 'json'

module Compliance
  class ErrorSerializer < Serializer
    def wrap(error_text)
      {
        response: {
          error: error_text
        }
      }
    end

    def call(response_body)
      error_text = JSON.parse(response_body)['errors'].map do |msg|
        msg['message']
      end.join(' ')
      wrap(error_text)
    end
  end
end
