require 'net/http'

module PayseraGateway
  # Paysera supported payment methods data.
  class PMData
    class << self
      def fetch(options)
        unless options[:projectid]
          raise ParamError, 'Required param "projectid" missing.'
        end

        @projectid = options[:projectid]
        @currency  = options[:currency]
        @amount    = options[:amount]
        @language  = options[:language]

        paysera_payment_methods
      end

      private

      def paysera_uri
        URI("https://www.paysera.com/new/api/paymentMethods/#{@projectid}/"\
            "currency:#{@currency}/amount:#{@amount}/language:#{@language}")
      end

      def paysera_payment_methods
        response = Net::HTTP.get(paysera_uri)
        Hash.from_xml(response)
      end
    end
  end
end
