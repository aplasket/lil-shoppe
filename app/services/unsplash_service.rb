class UnsplashService
  def random_image
    get_url("https://api.unsplash.com/photos/random?client_id=Cjt-hWbk-mUPw5b54DtrDD5KolUeXdbdIBGaKsPU-k4")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end

