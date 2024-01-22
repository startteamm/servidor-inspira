module Jwt
  class Base
    SECRET = "asfkdljr2u89543=45[we[fwpf=3405390erowfklznc[kmnbcvxzs]]"

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