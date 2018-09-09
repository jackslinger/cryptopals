#  One of the 60-character strings in this file has been encrypted by single-character XOR.

# Find it.

# (Your code from #3 should help.) 

require_relative 'helpers/single_char_xor_decrypter'
require_relative 'helpers/ascii_coder'

def score_englishiness(string)
    # etaoin shrdlu
    score_map = [' ', 'e', 't', 'a', 'o', 'i', 'n', 's', 'h', 'r', 'd', 'l', 'u'].reverse.each_with_index.map{ |char, i| [char, (i+1)] }.to_h

    score = 0
    score_map.each do |k,v|
        score += string.count(k) * v
    end
    score
end

possible_keys = ('a'..'z').to_a + ('A'..'Z').to_a
decrypter = Helpers::SingleCharXorDecrypter.new(scoring_method: Proc.new{|string| score_englishiness(string)})

# lines = File.open('./set1_4_data.txt').readlines

decrypted_lines = []
File.open('./set1_4_data.txt').each_line do |line|
    text, key, score = decrypter.decrypt(Helpers::AsciiCoder.decode(line))
    decrypted_lines << [score, text]
end

puts decrypted_lines.sort{|a,b| b[0] <=> a[0] }.first(1).map{|v| v[1]}
