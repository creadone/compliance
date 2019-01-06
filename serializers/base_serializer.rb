# frozen_string_literal: true

require 'json'

module Compliance
  class Serializer
    def wrap(name, attrs); end

    def call(response_body); end
  end
end
