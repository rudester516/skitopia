module Weatherbit
  class Client
    API_ENDPOINT = 'https://api.weatherbit.io/v2.0/'.freeze

    attr_reader :auth_token
  
    def initialize(auth_token = nil)
      @auth_token = auth_token
    end

    def forecast(postal_code)
      request(
        http_method: :get,
        endpoint: "forecast/daily?postal_code=#{postal_code}&units=I&key=#{auth_token}"
      )
    end

    private

      def client
        @_client ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter

        end
      end

      def request(http_method:, endpoint:, params: {})
        response = client.public_send(http_method, endpoint, params)
        Oj.load(response.body)
      end
  end
end