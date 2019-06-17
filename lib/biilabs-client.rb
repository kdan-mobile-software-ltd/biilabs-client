class BiilabsClient
  attr_reader :config

  def initialize
    config_path = 'config/biilabs-client.yml'
    env = ENV['RAILS_ENV'] || 'development'
    string = File.open(config_path, 'rb') { |f| f.read }
    fail "#{config_path} not existed nor not readable" if string.nil?
    @config = YAML.load(string)[env]
    fail "#{config_path} incorrect or environment not exist" if @config.nil?
  end

  def post_tangle(tag, message)
    path = '/transaction'
    body = {
      tag: tag.to_trytes.value,
      message: message
    }
    resp = connection.post do |req|
      req.url path
      req.headers['Content-Type'] = 'application/json'
      req.body = body.to_json
    end
    response_handler(resp)
  end

  def get_tangle(tangle_id)
    path = "/transaction/#{tangle_id}"
    resp = connection.get(path)
    response_handler(resp)
  end

  def get_tangle_by_tag(tag)
    path = "/tag/#{tag}"
    resp = connection.get(path)
    response_handler(resp)
  end

  private

  def connection
    @connection ||= Faraday.new(url: config['endpoint']) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      # faraday.response :logger                  # log requests and responses to $stdout
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def response_handler(resp)
    if resp.status == 200
      JSON.load(resp.body)
    else
      { status: resp.status, body: resp.body }
    end
  end
end

class String
  def to_trytes
    Trytes.new(self)
  end
end

class Trytes
  attr_reader :value

  def initialize(string)
    @value = string
    return if trytes?
    @value = ''
    string.each_char do |char|
      asciiValue = char.unpack('c*').first
      return if asciiValue > 255
      firstValue = asciiValue % 27
      secondValue = (asciiValue - firstValue) / 27
      tryte = trytes_chars[firstValue] + trytes_chars[secondValue]
      @value += tryte
    end
  end

  def to_string
    return unless trytes?
    string = ''
    (0..(value.length - 1)).step(2) do |i|
      tryte = value[i] + value[i + 1]
      break if tryte == '99'
      firstValue = trytes_chars.index(tryte[0])
      secondValue = trytes_chars.index(tryte[1])
      decimalValue = firstValue + secondValue * 27
      string += decimalValue.chr
    end
    string
  end

  private

  def trytes_chars
    '9ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  end

  def trytes?
    return false unless value.kind_of? String
    return false unless /^[9A-Z]*$/.match(value)
    true
  end
end
