#!/usr/bin/env ruby 
require 'pp'

def gstat(root, item)
	puts("INFO: checking: #{item}")
        md5sum = `~/go/bin/drive-google stat wms_data/#{item}`.split("\n")
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
	info = gstat(root,item)
	return false if info["does_not_exist"] 
	return true if File.size?(item) == info["bytes"].to_i
	false
end


ARGV.each do |set|

   list = `find #{set}  -type f `.split("\n").shuffle
   running_total = 0
   running_start = Time.now
   list.reverse.each do  |item|
	if ( check("wms_data", item) ) 
		puts("INFO: Good #{item}")
		next 
	else
		puts("INFO: Bad/Missing #{item}")		
	end
	system(" ~/go/bin/drive-google push -no-prompt -no-clobber -upload-chunk-size 268435456 -destination wms_data/ #{item}")
	running_total += File.size(item)
	if running_total > 1024*1024*1024*350
		puts "INFO: Sleeping.. , limit reached.."
		end_time =  running_start + 60*60*12
		while ( Time.now < end_time ) do 
			puts("INFO: waiting until #{end_time.to_s} to start again..")
			puts("INFO:\tThat is #{(((end_time-Time.now)/6).to_i)/10.0}")
			sleep(20*60) #20 minutes
		end
		puts ("INFO: Starting again")
		running_total = 0
		running_start = Time.now
	else
		puts "Running total is #{running_total/(1024*1024)} Mb"
	end
   end
end
