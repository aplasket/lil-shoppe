require "httparty"
require "json"
require "./app/services/unsplash_service"
require "./app/poros/random_image"

class RandomSearch
  def new_random_image
    RandomImage.new(service.random_image)
  end

  def service
    UnsplashService.new
  end
end