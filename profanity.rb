#!/usr/bin/env ruby

require './obscenity'

file_name = ARGV[0]

file = File.open(file_name, "r")
book = file.read
file.close

edited_book = Obscenity.replacement("[censored]").sanitize(book)
out = File.new(file_name + ".edited.txt", "w")
out.write(edited_book)
out.close
