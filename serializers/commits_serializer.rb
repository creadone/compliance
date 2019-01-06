# frozen_string_literal: true

require 'json'

module Compliance
  class CommitsSerializer < Serializer
    def wrap(repo_name, commits)
      {
        response: {
          repo: {
            name: repo_name,
            commits: commits
          }
        }
      }
    end

    def parse_and_extract_branches(response_body)
      hash = JSON.parse(response_body)
      repo_name = hash['data']['repository']['name']
      nodes = hash['data']['repository']['ref']['target']['history']['edges']
      [repo_name, nodes]
    end

    def call(response_body)
      repo_name, nodes = parse_and_extract_branches(response_body)
      commits = nodes.map do |commit|
        {
          message: commit['node']['messageHeadline'],
          commit_date: commit['node']['committedDate']
        }
      end
      wrap(repo_name, commits)
    end
  end
end
