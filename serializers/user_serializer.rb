# frozen_string_literal: true

require 'json'

module Compliance
  class UserSerializer < Serializer
    def wrap(name, repositories)
      {
        response: {
          user: {
            name: name
          },
          repositories: repositories
        }
      }
    end

    def call(response_body)
      body_hash = JSON.parse(response_body)
      name = body_hash['data']['user']['name']
      repos = body_hash['data']['user']['repositories']['edges'].map do |repo|
        {
          name: repo['node']['name'],
          created_at: repo['node']['created_at']
        }
      end
      wrap(name, repos)
    end
  end
end
