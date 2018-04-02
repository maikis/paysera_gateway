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
      it 'adds error if params are missing required fields' do
        req = Request.new({})
        req.valid?
        expect(req.errors.messages)
          .to include(projectid: ["Param \"projectid\" is required."])
      end

      it 'adds error if params includes unknown field' do
        required_params = [:a]
        additional_params =  [:b]
        params = { a: 1, b: 2, c: 3 }
        config = class_double(
          'PayseraGateway::Configuration',
          required_params: [:a],
          additional_params: [:b]
        )
        allow_any_instance_of(Request).to receive(:config).and_return(config)
        request = Request.new(params)
        request.valid?
        expect(request.errors.messages)
          .to include(c: ["Unknown param \"c\"."])
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
