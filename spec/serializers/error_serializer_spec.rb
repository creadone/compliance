require_relative '../spec_helper'
require_relative '../../serializers/base_serializer'
require_relative '../../serializers/error_serializer'

describe 'serializers/error_serializer.rb' do
  context 'When testing the ErrorSerializer class' do
    let(:response_body) do
      {
        "data" => {
          "user" => nil
        },
      "errors" => [
        {
          "message" => "Could not resolve to a User with the login of 'matz1111'.",
          "type" => "NOT_FOUND",
          "path" => ["user"],
            "locations" => [
              {
                "line" => 2,
                "column" => 3
              }
            ]
          }
        ]
      }.to_json
    end

    it 'should return serialized hash' do
      expect(Compliance::ErrorSerializer.new.call(response_body).is_a?(Hash)).to be_truthy
    end
  end
end
