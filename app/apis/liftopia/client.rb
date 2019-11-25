module Liftopia
  class Client
    API_ENDPOINT = 'https://www.liftopia.com/api/pricing/v1/'.freeze

    attr_reader :auth_token

    def initialize(auth_token = nil)
      @auth_token = auth_token
    end

    def products(store_id)
      request(
        http_method: :get,
        endpoint: "products?store_id=#{store_id}"
      )
    end

    def product(store_id, product_id)
      request(
        http_method: :get,
        endpoint: "products/#{product_id}?store_id=#{store_id}"
      )
    end

    private

      def client
        @_client ||= Faraday.new(API_ENDPOINT) do |client|
          client.request :url_encoded
          client.adapter Faraday.default_adapter
          client.headers['Authorization'] = "Bearer #{auth_token}" if auth_token.present?
        end
      end
      
      def request(http_method:, endpoint:, params: {})
        response = client.public_send(http_method, endpoint, params)
        Oj.load(response.body)
      end
  end
end