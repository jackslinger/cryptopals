module Helpers
    class SingleCharXorDecrypter

        require_relative 'ascii_coder'

        attr_reader :scoring_method

        def initialize(scoring_method:)
            @scoring_method = scoring_method
        end

        def decrypt(cypher_text)
            highest_scoring_string = cypher_text
            higest_scoring_key = nil
            highest_score = 0

            possible_keys.each do |key|
                new_string = AsciiCoder.decode(single_char_hex_xor(AsciiCoder.encode(cypher_text), key))
                new_score = scoring_method.call(new_string)
    
                if new_score > highest_score
                    highest_scoring_string = new_string
                    higest_scoring_key = key
                    highest_score = new_score
                end
            end

            return [highest_scoring_string, higest_scoring_key, highest_score]
        end

        private

        def possible_keys
            @possible_keys ||= (0..15).map{|v| "0#{v.to_s(16)}"} + (17..255).map{|v| v.to_s(16)}
        end

        def single_char_hex_xor(input, hex_key)
            padded_key = hex_key * (input.size / 2)
            return (input.hex ^ padded_key.hex).to_s(16)
        end

    end
end