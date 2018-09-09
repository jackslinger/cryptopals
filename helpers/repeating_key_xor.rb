module Helpers
    class RepeatingKeyXor

        require_relative 'ascii_coder'

        attr_accessor :key

        def initialize(key:)
            @key = key
        end

        def encrypt(plain_text)
            padded_key = repeating_key_of(length: plain_text.size)

            output = plain_text.chars.each_with_index.map do |char, i|
                moo = (AsciiCoder.encode(char).hex ^ AsciiCoder.encode(padded_key[i]).hex).to_s(16)
                moo.size == 2 ? moo : "0#{moo}" 
            end.join('')
            output
        end

        def decrypt(cypher_text)
            # Symetric key and algorithm
            encrypt(cypher_text)
        end

        private

        def repeating_key_of(length:)
            division = length / key.size
            modulo = length % key.size
            if modulo == 0
                (key * division)
            else
                (key * division) + key[0..modulo-1]
            end
        end

    end
end