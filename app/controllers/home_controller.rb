class HomeController < ApplicationController
  def index
    client = Liftopia::Client.new('3ba8d43a3ed83721d12d77568081b5d9b7097dbcffae4a38cb511be4d30240bc')
    @products = client.products('763')
  end

  def product
    product_id = params[:id]
    liftopia_client = Liftopia::Client.new('3ba8d43a3ed83721d12d77568081b5d9b7097dbcffae4a38cb511be4d30240bc')
    @product = liftopia_client.product('763', product_id)
    weather_client = Weatherbit::Client.new('7a9eee94f68a40d093559833bd3261f7')
    forecast = weather_client.forecast('96146')
    @forecast = forecast["data"]
  end

  def weather
    client = Weatherbit::Client.new('7a9eee94f68a40d093559833bd3261f7')
    forecast = client.forecast('96146')
    @forecast = forecast["data"]
    render json: @forecast
  end
end
