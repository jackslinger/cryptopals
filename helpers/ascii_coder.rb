module Helpers
    class AsciiCoder

        def self.encode(string)
            output = []
            string.chars.each do |char|
                output << char.ord.to_s(16)
            end
            output.join('')
        end

        def self.decode(hex_string)
            output = []
            hex_string.scan(/.{2}/).each do |hex_code|
                output << hex_code.hex.chr
            end
            output.join('')
        end

    end
end