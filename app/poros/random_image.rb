class RandomImage
  attr_reader :random_photo

  def initialize(data)
    @random_photo = data[:urls][:small]
  end
end