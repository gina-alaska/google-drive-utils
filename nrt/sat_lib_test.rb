require_relative './sat_lib'

list = []
list << "METOP-B.20180328.000252.dat.gz"
list << "METOP-B.20180328.000252.dat.gz.md5"
list << "METOP-B.20180328.014444.dat.gz"
list << "METOP-B.20180328.014444.dat.gz.md5"
list << "METOP-B.20180328.031512.dat.gz"
list << "METOP-B.20180328.031512.dat.gz.md5"
list << "METOP-B.20180328.045327.dat.gz"
list << "METOP-B.20180328.045327.dat.gz.md5"
list << "METOP-B.20180328.063321.dat.gz"
list << "METOP-B.20180328.063321.dat.gz.md5"

list << "JPSS1.20180915.091842.dat.gz"
list << "JPSS1.20180915.091842.dat.gz.md5"
list << "JPSS1.20180915.105819.dat.gz"
list << "JPSS1.20180915.105819.dat.gz.md5"
list << "JPSS1.20180915.123840.dat.gz"
list << "JPSS1.20180915.123840.dat.gz.md5"
list << "JPSS1.20180915.141904.dat.gz"
list << "JPSS1.20180915.141904.dat.gz.md5"
list << "JPSS1.20180915.155852.dat.gz"
list << "JPSS1.20180915.155852.dat.gz.md5"






list.each do |item|
	puts item
	s = Satellite.new( item)
	puts s.archive_path
	#puts "Source: #{s.get_floating_source()}"
	#puts "Leg: #{s.get_legend()}"
end
