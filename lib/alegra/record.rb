# frozen_string_literal: true

module Alegra
  class Record
    attr_reader :client

    def initialize(client)
      @client = client
    end
  end
end
