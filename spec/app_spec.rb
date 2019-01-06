require_relative '../spec_helper'
require_relative '../../serializers/base_serializer'
require_relative '../../serializers/error_serializer'

describe 'app.rb' do
  context 'When testing the Server class' do
    it 'should return serialized hash' do
      expect(Compliance::ErrorSerializer.new.call(response_body).is_a?(Hash)).to be_truthy
    end
  end
end
