module Jwt
  class Base
    SECRET = ENV['SECRET_KEY']

    def self.encode(payload)
      JWT.encode(payload, SECRET, 'HS256')
    end

    def self.decode(token)
      JWT.decode(token, SECRET)
    rescue JWT::DecodeError
        nil
    end
  end
end