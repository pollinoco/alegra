# frozen_string_literal: true

require 'faraday'
require 'json'
require 'base64'

module Alegra
  class Setup
    attr_accessor :host, :path, :apikey, :username, :debug, :token

    def initialize(username = nil, apikey = nil, debug = false)
      @host = 'https://app.alegra.com/'
      @path = 'api/v1/'

      @debug = debug

      unless apikey
        raise 'set up the ALEGRA_APIKEY environment variable' unless ENV['ALEGRA_APIKEY']

        @apikey = ENV['ALEGRA_APIKEY']

        # apikey = read_configs

      end

      unless username
        raise 'set up the ALEGRA_USERNAME environment variable' unless ENV['ALEGRA_USERNAME']

        @username = ENV['ALEGRA_USERNAME']

        # apikey = read_configs

      end

      raise Error, 'You must provide a ALEGRA API key' unless apikey
      raise Error, 'You must provide a ALEGRA USERNAME' unless username

      @apikey = apikey
      @username = username
      create_token!
    end

    def create_token!
      @token = ::Base64.strict_encode64("#{@username}:#{@apikey}")
    end
  end
end
