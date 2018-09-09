class BaseConverter

    def hex_to_base64(hex_input)
        base10_number = hex_input.to_i(16)
        number = []
        input = base10_number
        while (input / 64) > 0
            number << (input % 64)
            input = input / 64
        end
        number << (input % 64)

        return number.reverse.map{|n| self.class.base64_hash[n] }.join('')
    end

    private

    def self.base64_hash()
        @base64_hash ||= begin
            base64_keys = ('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a + ['+', '/']
            base64_keys.each_with_index.map{ |k, i| [i, k] }.to_h
        end
    end

end
