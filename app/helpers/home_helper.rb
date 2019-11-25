module HomeHelper

  def weather_forecast(w)
    if w.present?
      tag.div do
        concat image_tag "weather/icons/#{w["weather"]["icon"]}.png"
        concat tag.span w["weather"]["description"]
        concat tag.br
        concat tag.span "High/Low: #{w["max_temp"].to_i}° / #{w["min_temp"].to_i}°"
        concat tag.br
        concat tag.span "Max Winds: #{w["wind_gust_spd"].to_i} mph from #{w["wind_cdir"]}"
        concat tag.br
        concat tag.span "Expected Snow: #{w["snow"].to_i} inches"
        concat tag.br
        concat tag.span "Snow Depth: #{w["snow_depth"].to_i} inches"
        concat tag.hr
      end
    else
      tag.p "Weather Unavailable"
    end  
  end

  def pricing(price, weather)
    if weather.present?
      weather_code = weather["weather"]["code"].to_s
      tag.div do
        concat tag.span number_to_currency(price.to_f * Weather::WEATHER_CODES[weather_code].to_f)
        concat tag.span " (#{number_to_currency(price)})"
      end
    else
      number_to_currency(price)
    end
  end
end
