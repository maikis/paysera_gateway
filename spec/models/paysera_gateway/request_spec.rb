require 'rails_helper'

module PayseraGateway
  RSpec.describe Request, type: :model do
    let(:config) do
      class_double(
        'PayseraGateway::Configuration',
        required_params: [:a],
        additional_params: [:b]
      )
    end

    let(:params) { { a: 1, b: 2, sign_password: 3 } }

    it 'has params' do
      expect(described_class.new(params).params).to eq(params)
    end

    it 'extracts sign_password from params on initialization' do
      request = described_class.new(params.dup)
      expect(request.sign_password).to eq(params[:sign_password].to_s)
    end

    context 'validation' do
      it 'adds error if params are missing required fields' do
        allow_any_instance_of(Request).to receive(:config).and_return(config)
        request = Request.new({})
        request.valid?
        expect(request.errors.messages)
          .to eq(a: ["Param \"a\" is required."])
      end

      it 'adds error if params includes unknown field' do
        params = { a: 1, c: 3 }
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
        sign = Digest::MD5.hexdigest(data + sign_password.to_s)
        expect(request.build).to eq(data: data, sign: sign)
      end
    end
  end
end
