require 'rails_helper'

module PayseraGateway
  RSpec.describe ParamsValidator, type: :model do
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

    let(:additional_params) do
      additional_p = params_config[:additional]
      params = {}
      additional_p.each { |param| params[param] = param.to_s }
      params
    end

    it 'returns params if they are valid' do
      expect(described_class.validate(params)).to eq(params)
    end

    context 'presence' do
      it 'validates required param presence' do
        expect { described_class.validate({}) }.to raise_error do |error|
          expect(error).to be_a(PayseraGateway::Errors::ValidationError)
          expect(error.message).to eq('Required parameters are missing.')
          expect(error.details).to be_a(Hash)
          expect(error.details.size).to eq(6)
        end
      end
    end

    context 'additional params' do
      it 'removes params that are not in configuration' do
        all_params = params.merge(additional_params)
        with_unknown_params = all_params.merge(unknown_param: 'what is this?')
        expect { described_class.validate(with_unknown_params) }.to raise_error do |error|
          expect(error).to be_a(PayseraGateway::Errors::ValidationError)
          expect(error.message).to eq('Unknown param found.')
          expect(error.details).to be_a(Hash)
          expect(error.details.size).to eq(1)
        end
      end
    end
  end
end
