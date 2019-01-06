require_relative '../spec_helper'
require_relative '../../serializers/base_serializer'
require_relative '../../serializers/user_serializer'

describe 'serializers/user_serializer.rb' do
  context 'When testing the UserSerializer class' do
    let(:response_body) do
      {
        "data" => {
            "user" => {
              "name" => "Yukihiro \"Matz\" Matsumoto",
            "repositories" => {
              "edges" => [
                {
                  "node" => {
                    "name" => "mruby-onig-regexp",
                    "created_at" => "2018-11-19T08:46:27Z"
                  }
                }
              ]
            }
          }
        }
      }.to_json
    end

    it 'should return serialized hash' do
      expect(Compliance::UserSerializer.new.call(response_body).is_a?(Hash)).to be_truthy
    end
  end
end
