#!/usr/bin/env ruby

require './obscenity'

file_name = ARGV[0]
number_sanitized = 0
percent_complete = 0
total_sentences = 0

# start background thread
t = Thread.new do

  # read the file into a string
  file = File.open(file_name, "r")
  book = file.read
  file.close

  # get the segments between periods
  sentences = book.split(/\./)
  total_sentences = sentences.length

  # open file to write
  out = File.new(file_name + ".edited.txt", "w")

  # sanitize all of the strings and write them out
  sentences.each do |sentence|
    edited = Obscenity.replacement("[censored]").sanitize(sentence) << '.'
    out.write(edited)

    # track numbers
    number_sanitized += 1
    percent_complete = (((number_sanitized * 1.0) / (total_sentences * 1.0)) * 100).round
  end

  out.close
end

chars = ['/', '-', '\\', '|']
char_index = 0
while percent_complete < 100 do
  print "#{chars[char_index]} #{percent_complete}% [#{'#' * (percent_complete / 4)}#{'-' * (25 - percent_complete / 4)}] [#{number_sanitized}/#{total_sentences}]   \r"
  # the human brain cannot track faster than 200 milliseconds so don't waste your time
  sleep(0.2)
  # spin the wheel
  char_index = (char_index + 1) % chars.length
end
print "#{percent_complete}% [#{'#' * 25}] [#{total_sentences}/#{total_sentences}]   \n"

t.join
