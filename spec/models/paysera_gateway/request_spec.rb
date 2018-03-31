require 'rails_helper'

module PayseraGateway
  RSpec.describe Request, type: :model do
    let(:params_config) do
      config_file = File.expand_path(
        'app/models/paysera_gateway/config/params.yml'
      )
      YAML.load_file(config_file)
    end

    let(:params) do
      req = params_config[:required]
      params = {}
      req.each { |param| params[param] = param.to_s }
      params
    end

    it 'has params' do
      expect(described_class.new(params).params).to eq(params)
    end

    it 'extracts sign_password from params on initialization' do
      request = described_class.new(params.dup)
      expect(request.sign_password).to eq(params[:sign_password])
    end

    context 'validation' do
      it 'raises ValidationError if params are missing required fields' do
        expect { described_class.new({}) }.to raise_error do |error|
          expect(error).to be_a(PayseraGateway::Errors::ValidationError)
          expect(error.message).to eq('Required parameters are missing.')
        end
      end
    end

    describe '#build' do
      it 'generates valid paysera request data' do
        request = described_class.new(params.dup)
        sign_password = params.delete(:sign_password)
        encoded_params = URI.encode_www_form(params)
        data = Base64.strict_encode64(encoded_params)
        data = data.tr('/', '_').tr('+', '-')
        sign = Digest::MD5.hexdigest(data + sign_password)
        expect(request.build).to eq(data: data, sign: sign)
      end
    end
  end
end
