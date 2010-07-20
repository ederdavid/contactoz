#!/usr/bin/env ruby
$KCODE = 'u'
require 'iconv'
require 'set'

require 'charguess'

ic_ignore = Iconv.new('LATIN1//IGNORE', 'UTF-8')

#File.foreach('path/to/file') do |line|
#  first, second, third = line.split(/\W+/, 3)
  # look at variables and determine what to do
#end

s = "CONSTRUCCIÔøΩN"

of = File.open('/Users/tina/Desktop/contact/app/controllers/cleanfile.csv', "w") 
of_convrted = Iconv.new(CharGuess::guess of, 'utf-8').iconv(of)

	clean = ic_ignore.iconv(s)
	of_converted.puts clean
	puts clean 


