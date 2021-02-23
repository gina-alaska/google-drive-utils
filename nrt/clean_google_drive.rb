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
	puts info["md5checksum"]
	return false if info["does_not_exist"] 
	if File.size?(item) == info["bytes"].to_i
		md5sum = `md5sum #{item}`.split(/\s+/).first
		puts "INFO: local md5sum #{md5sum}, remote #{info["md5checksum"]}"
		return true if md5sum == info["md5checksum"]
	end
	false
end


not_done = []
not_done_size = 0
done = []
done_size = 0


ARGV.each do |set|
   list = `find #{set}  -type f `.split("\n").shuffle
   running_total = 0
   running_start = Time.now

   list.reverse.each do  |item|
	s = Satellite.new( item)
	next if s.unknown?
	size = File.size?(item)
	size = 0 if !size
	if ( check(s.archive_path, item) ) 
		puts("INFO: Archived - deleting #{item}")
		FileUtils.rm(item)
		done << item
		done_size += size
	else
		puts("INFO: Bad/Missing #{item}")		
		not_done << item
		not_done_size += size
	end
   end
end


puts "INFO: Summery\n----------------------------------"
puts "Deleted:\t#{done.length}\t#{done_size.to_f/(1024*1024*1024)}Gb"
puts "To Go  :\t#{not_done.length}\t#{not_done_size.to_f/(1024*1024*1024)}Gb"

