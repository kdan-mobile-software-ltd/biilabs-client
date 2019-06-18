require 'string'
require 'trytes'

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
    path = "/tag/#{tag.to_trytes.value}"
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
