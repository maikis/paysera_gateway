module PayseraGateway
  # Request constructor class.
  class Request
    include ActiveModel::Validations

    attr_reader :params, :sign_password

    validate :required_params_presence, :unknown_params

    def initialize(params)
      @params = params
      @sign_password = params.delete(:sign_password).to_s
    end

    def build
      { data: base64_encoded_data, sign: sign }
    end

    private

    def sign
      Digest::MD5.hexdigest(base64_encoded_data + sign_password)
    end

    def base64_encoded_data
      data = Base64.strict_encode64(encoded_params)
      data.tr('/', '_').tr('+', '-')
    end

    def encoded_params(params_to_encode = params)
      URI.encode_www_form(params_to_encode)
    end

    def required_params_presence
      config.required_params.each do |required_param|
        unless params.keys.include?(required_param)
          errors.add(required_param, "Param \"#{required_param}\" is required.")
        end
      end
    end

    def unknown_params
      known_params = config.required_params + config.additional_params
      params.keys.each do |param|
        unless known_params.include?(param)
          errors.add(param, "Unknown param \"#{param}\".")
        end
      end
    end

    def config
      PayseraGateway::Configuration
    end
  end
end

