require_relative '../spec_helper'
require_relative '../../serializers/base_serializer'
require_relative '../../serializers/unauth_serializer'

describe 'serializers/unauth_serializer.rb' do
  context 'When testing the UnauthSerializer class' do
    let(:response_body) do
      {
        "message" => "Bad credentials",
        "documentation_url" => "https://developer.github.com/v4"
      }.to_json
    end

    it 'should return serialized hash' do
      expect(Compliance::UnauthSerializer.new.call(response_body).is_a?(Hash)).to be_truthy
    end
  end
end
