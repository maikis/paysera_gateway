require 'net/http'

module PayseraGateway
  # Paysera supported payment methods data.
  class PMData
    class << self
      def fetch(options)
        unless options[:projectid]
          raise ParamError.new('Required param "projectid" missing.')
        end

        projectid = options[:projectid]
        currency = options[:currency]
        amnt = options[:amount]
        lang = options[:language]

        url = "https://www.paysera.com/new/api/paymentMethods/#{projectid}/"\
              "currency:#{currency}/amount:#{amnt}/language:#{lang}"
        uri = URI(url)

        response = Net::HTTP.get(uri)
        resp_hsh = Hash.from_xml(response)
        resp_hsh.deep_symbolize_keys
      end
    end
  end
end
