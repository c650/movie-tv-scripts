#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'

=begin

	This program rips and formats movie scripts from springfieldspringfield.co.uk
	into processable text for my markov plugin.

=end

URL = "https://www.springfieldspringfield.co.uk/"

def grab(link)
	Nokogiri::HTML(open(link)).css(".scrolling-script-container").first.text.tr('-','')
end

def process_show(link)
	Nokogiri::HTML(open(link)).css(".season-episodes").each do |season|
		season.css("a").each do |episode|
			puts grab(URL + episode["href"]).strip
		end
	end
end

if ARGV.empty?
	puts "Usage: ./program.rb #{URL}movie_script.php?movie=[MOVIE] ..."
	exit
end

links = ARGV[1...ARGV.length]

if ARGV[0] == "MOV"
	links.each do |link|
		puts grab(link).strip
	end
else
	links.each do |link|
		process_show(link)
	end
end
