require_relative '../spec_helper'
require_relative '../../config'
require_relative '../../serializers/base_serializer'
require_relative '../../serializers/error_serializer'
require_relative '../../serializers/user_serializer'
require_relative '../../queries/base_query'

describe 'queries/base_query.rb' do
  context 'When testing the Query class' do
    let(:query){ Compliance::Query.new('user.graphql', login: 'matz', repositories_number: 10) }

    it 'should glue the name and find the serializer' do
      expect(query.serializer.name).to eq 'Compliance::UserSerializer'
    end

    it 'should build and return the graphql query' do
      expect(query.to_graphql).to include("query")
    end

    it 'should build and return json' do
      expect(query.to_json).to include('{"query":')
    end

    it 'should return serialized error response' do
      stub_request(:post, CONFIG.api_url).to_return(
        status: 200,
        body: { errors: [{message: 'message 1'}, {message: 'message 2'}]}.to_json
      )
      expect(query.call.to_s).to include(":response")
    end
  end
end
