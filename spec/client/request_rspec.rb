require_relative '../spec_helper'
require_relative '../../config'
require_relative '../../client/request'
require_relative '../../client/response'

describe 'client/request.rb' do
  context 'When testing the Request class' do
    let(:response){ Compliance::Request.new("{}").call }

    it 'instance should have API URL after initialize' do
      request = Compliance::Request.new('some body')
      expect(request.uri.host).to eq 'api.github.com'
    end

    it 'should return true if received successful response' do
      stub_request(:post, CONFIG.api_url).to_return(
        body: { key: 'value' }.to_json,
        status: 200
      )
      expect(response.success?).to eq true
    end

    it 'should return false if received unsuccessful response' do
      stub_request(:post, CONFIG.api_url).to_return(
        status: 200,
        body: { errors: 'error message' }.to_json
      )
      expect(response.success?).to eq false
    end

    it 'should return Response class' do
      stub_request(:post, CONFIG.api_url).to_return(status: 200)
      expect(response).to be_a_kind_of(Compliance::Response)
    end
  end
end
