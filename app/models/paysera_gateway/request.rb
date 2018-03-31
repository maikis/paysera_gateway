module PayseraGateway
  class Request
    attr_reader :params, :sign_password

    def initialize(params)
      @params = params_validator.validate(params)
      @sign_password = params.delete(:sign_password)
    end

    def build
      { data: base64_encoded_data, sign: sign }
    end

    private

    def params_validator
      PayseraGateway::ParamsValidator
    end

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
  end
end
