#  The hex encoded string:

# 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736

# ... has been XOR'd against a single character. Find the key, decrypt the message.

# You can do this by hand. But don't: write code to do it for you.

# How? Devise some method for "scoring" a piece of English plaintext. Character frequency is a good metric.
# Evaluate each output and choose the one with the best score.

require_relative 'helpers/single_char_xor_decrypter'
require_relative 'helpers/ascii_coder'

def score_englishiness(string)
    # etaoin shrdlu
    score_map = %w(e t a o i n s h r d l u).reverse.each_with_index.map{ |char, i| [char, (i+1)] }.to_h

    score = 0
    score_map.each do |k,v|
        score += string.count(k) * v
    end
    score
end

input = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
cypher_text = Helpers::AsciiCoder.decode(input)

highest_scoring, _ = Helpers::SingleCharXorDecrypter.new(scoring_method: Proc.new{|v| score_englishiness(v)}).decrypt(cypher_text)
puts highest_scoring

