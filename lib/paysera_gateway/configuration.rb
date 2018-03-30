require 'yaml'
module PayseraGateway
  # Class to handle configuration files.
  class Configuration
    PARAMS = YAML.load_file(File.join(__dir__, 'config/params.yml'))

    class << self
      def required_params
        PARAMS[:required]
      end

      def additional_params
        PARAMS[:additional]
      end
    end
  end
end
