class Api::PlacesController < ApplicationController
  # BASE_URL = "https://maps.googleapis.com/maps/api/place/"
  @@places_url = "https://maps.googleapis.com/maps/api/place/"
  @@geo_url = "https://www.googleapis.com/geolocation/v1/geolocate"
  API_KEY = ENV["API_KEY"]
  # @@current_location = "36.59783,-121.84038"

  def nearby
    # First create our url
    full_url = "#{@@places_url}nearbysearch/json?key=#{API_KEY}&location=#{params[:lat]},#{params[:lng]}&radius=500&type=#{params[:type]}"
    p full_url
    p params
    uri = URI(full_url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    get_request = Net::HTTP::Get.new(uri)
    response = https.request(get_request)

    body = JSON.parse(response.body)
    p body
    results = body["results"]
    things_the_frontend_needs_as_an_array = results.map do |entry|
      {
        name: entry["name"],
        location: "#{entry["geometry"]["location"]["lat"]},#{entry["geometry"]["location"]["lng"]}"
      }
    end

    render json: things_the_frontend_needs_as_an_array
  end

  def findme
    full_url = @@geo_url + "?key=" + API_KEY
    uri = URI(full_url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    post_request = Net::HTTP::Post.new(uri)
    response = https.request(post_request)
    debugger
    render json: response.read_body
  end

end
