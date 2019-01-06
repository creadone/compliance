require_relative 'spec_helper'
require_relative '../app.rb'

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods

  def app
    Compliance::Server
  end
end

RSpec.configure { |c| c.include RSpecMixin }

describe 'app.rb' do
  context 'When testing the Server class' do
    it 'should return the tip how to make request' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('Try /:login')
    end
  end
end
