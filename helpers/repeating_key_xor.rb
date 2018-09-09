module Helpers
    class RepeatingKeyXor

        require_relative 'ascii_coder'

        attr_accessor :key

        def initialize(key:)
            @key = key
        end

        def encrypt(plain_text)
            plain_text.bytes.each_with_index.map do |byte, i|
                key_byte = key[i % key.size].ord
                (byte ^ key_byte).to_s(16).rjust(2, '0')
            end.join('')
        end

        def decrypt(cypher_text)
            # Symetric key and algorithm
            encrypt(cypher_text)
        end

    end
end