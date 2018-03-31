module PayseraGateway
  # Validator for Paysera request params.
  class ParamsValidator
    REQUIRED_PARAMS_MSG = 'Required parameters are missing.'.freeze
    UNKNOWN_PARAM_MSG   = 'Unknown param found.'.freeze

    class << self
      def validate(params)
        required(params)
        unknown_params(params)
        params
      end

      private

      def required(params)
        errors = {}
        config.required_params.each do |required_param|
          unless params.keys.include?(required_param)
            errors[required_param] = "Param \"#{required_param}\" is required."
          end
        end
        raise_error(REQUIRED_PARAMS_MSG, errors) unless errors.empty?
        params
      end

      def unknown_params(params)
        errors = {}
        known_params = config.required_params + config.additional_params
        params.keys.each do |param|
          unless known_params.include?(param)
            errors[param] = "Unknown param \"#{param}\"."
          end
        end
        raise_error(UNKNOWN_PARAM_MSG, errors) unless errors.empty?
        params
      end

      def config
        PayseraGateway::Configuration
      end

      def raise_error(message, details)
        raise Errors::ValidationError.new(message, details)
      end
    end
  end
end
