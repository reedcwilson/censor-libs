#!/usr/bin/env ruby

require './obscenity'

file_name = ARGV[0]

file = File.open(file_name, "r")
book = file.read
file.close

sentences = book.split(/\./)

out = File.new(file_name + ".edited.txt", "w")

sentences.each do |sentence|
  edited = Obscenity.replacement("[censored]").sanitize(sentence)
  out.write(edited)
end

out.close
