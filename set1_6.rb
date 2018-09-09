# There's a file here. It's been base64'd after being encrypted with repeating-key XOR.

# Decrypt it.

# Here's how:

# Let KEYSIZE be the guessed length of the key; try values from 2 to (say) 40.
# Write a function to compute the edit distance/Hamming distance between two strings. The Hamming distance is just the number of differing bits. The distance between:
# this is a test
# and
# wokka wokka!!!
# is 37. Make sure your code agrees before you proceed.
# For each KEYSIZE, take the first KEYSIZE worth of bytes, and the second KEYSIZE worth of bytes, and find the edit distance between them. Normalize this result by dividing by KEYSIZE.
# The KEYSIZE with the smallest normalized edit distance is probably the key. You could proceed perhaps with the smallest 2-3 KEYSIZE values. Or take 4 KEYSIZE blocks instead of 2 and average
# the distances.
# Now that you probably know the KEYSIZE: break the ciphertext into blocks of KEYSIZE length.
# Now transpose the blocks: make a block that is the first byte of every block, and a block that is the second byte of every block, and so on.
# Solve each block as if it was single-character XOR. You already have code to do this.
# For each block, the single-byte XOR key that produces the best looking histogram is the repeating-key XOR key byte for that block. Put them together and you have the key.
# This code is going to turn out to be surprisingly useful later on. Breaking repeating-key XOR ("Vigenere") statistically is obviously an academic exercise, a "Crypto 101" thing.
# But more people "know how" to break it than can actually break it, and a similar technique breaks something much more important.

cypher_text = File.open('./set1_6_data.txt').readlines.join('')

def hamming_dist_for_bytes(byte_one, byte_two)
    (byte_one ^ byte_two).to_s(2).count('1')
end

def hamming_dist_for_string(string_one, string_two)
    string_one.bytes.each_with_index.map do |byte, i|
        hamming_dist_for_bytes(byte, string_two.bytes[i])
    end.inject(&:+)
end

one = "this is a test"
two = "wokka wokka!!!"

puts hamming_dist_for_string(one, two)