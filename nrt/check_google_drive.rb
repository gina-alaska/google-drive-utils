#!/usr/bin/env ruby 
require 'pp'
require_relative './sat_lib'
require "fileutils"


def gstat(root, item)
	puts("INFO: checking: #{item}")
	puts("INFO ~/gopath/bin/drive stat #{root}/#{File.basename(item)}")
        md5sum = `~/gopath/bin/drive stat #{root}/#{File.basename(item)}`.split("\n")
	md5sum.pop
	info = {}
	while (!md5sum.empty?)
		row = md5sum.pop.split(/\s{2,}/)
		next if row == nil || row.length == 0
		info[row.first.downcase] = row.last
	end
	
	info["does_not_exist"] = true if !info["bytes"]
	info
end

def check(root,item) 
	info = gstat(root,File.basename(item))
	return false if info["does_not_exist"] 
	return true if File.size?(item) == info["bytes"].to_i
	false
end


not_done = []
done = []


ARGV.each do |set|
   list = `find #{set}  -type f `.split("\n").shuffle
   list=list[0,10]
   running_total = 0
   running_start = Time.now

   list.reverse.each do  |item|
	s = Satellite.new( item)
	next if s.unknown?
	if ( check(s.archive_path, item) ) 
		puts("INFO: Good #{item}")
		done << item
	else
		puts("INFO: Bad/Missing #{item}")		
		not_done << item
	end
   end
end


puts "INFO: Done\n----------------------------------"
puts "\t#{done.join("\n\t")}"
puts "INFO: To Go\n----------------------------------"
puts "\t#{not_done.join("\n\t")}"
puts "INFO: Summery\n----------------------------------"
puts "Done:\t#{done.length}"
puts "To Go:\t#{not_done.length}"

