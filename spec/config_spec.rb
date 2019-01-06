require_relative '../config'

describe 'config.rb' do
  context 'When testing the Config class' do
    it 'should give set and read option' do
      config = Compliance.configure do |config|
        config.api_url = 'https://api.github.com/graphql'
      end
      expect(config.api_url).to eq 'https://api.github.com/graphql'
    end

    it 'should raise error if try to set unknown option' do
      expect {
        Compliance.configure{ |config| config.anything = 42 }
      }.to raise_error(NoMethodError)
    end
  end
end
