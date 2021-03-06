# frozen_string_literal: true
require "date"

class Satellite
  attr_reader :name
  attr_reader :acquired_at

  def initialize(pattern)
    @name, @acquired_at = parse_name(File.basename(pattern))
  end


#DMSP/2007/F12.07241.1615/f12.07241.161544.L0.gz.md5
  def archive_path
     puts @name
     case (@name)
        when /^f\d\d/ then  "UAFGINA/DMSP/"+@acquired_at.strftime("/%Y/")+@name.upcase+"."+ @acquired_at.strftime("%y%j.%H%M/")
	when /^n\d/ then  "UAFGINA/AVHRR"++@acquired_at.strftime("/%Y/")+@name.upcase+"."+@acquired_at.strftime("%y%j.%H%M/")
        else  "UAFGINA/#{@name}/#{@acquired_at.strftime('%Y/%03j')}/"
     end
  end

  def parse_name(filename)
    name = filename.downcase
    puts filename
    case name
    when /^npp.\d{5}.\d{4}/ then      ['npp', parse_date(name, 'npp.%y%j.%H%M')]
    when /^npp.\d{8}.\d{4}/ then      ['npp', parse_date(name, 'npp.%Y%m%d.%H%M')]
    when /^a1.\d{5}.\d{4}/ then       ['a1', parse_date(name, 'a1.%y%j.%H%M')]
    when /^aqua.\d{8}.\d{4}/ then     ['a1', parse_date(name, 'aqua.%Y%m%d.%H%M')]
    when /^t1.\d{5}.\d{4}/ then       ['t1', parse_date(name, 't1.%y%j.%H%M')]
    when /^terra.\d{8}.\d{4}/ then    ['t1', parse_date(name, 'terra.%Y%m%d.%H%M')]
    when /^tp\d{13}.metop-b.dat/ then ['metop-b', parse_date(name, 'tp%Y%j%H%M')]
    when /^tp\d{13}.metop-c.dat/ then ['metop-c', parse_date(name, 'tp%Y%j%H%M')]
    when /^metop-b.\d{8}.\d{6}/  then ['metop-b', parse_date(name, 'metop-b.%Y%m%d.%H%M')]
    when /^metop-c.\d{8}.\d{6}/  then ['metop-c', parse_date(name, 'metop-c.%Y%m%d.%H%M')]
    when /^f1\./ then 		     ['f1', parse_date(name, 'f1.%y%j.%H%M')]
    when /^f2/ then                  ['f2', parse_date(name, 'f2.%y%j.%H%M')]
    when /^f3/ then                  ['f3', parse_date(name, 'f3.%y%j.%H%M')]
    when /^f4/ then                  ['f4', parse_date(name, 'f4.%y%j.%H%M')]
    when /^f5/ then                  ['f5', parse_date(name, 'f5.%y%j.%H%M')]
    when /^f6/ then                  ['f6', parse_date(name, 'f6.%y%j.%H%M')]
    when /^f7/ then                  ['f7', parse_date(name, 'f7.%y%j.%H%M')]
    when /^f8/ then                  ['f8', parse_date(name, 'f8.%y%j.%H%M')]
    when /^f9/ then                  ['f9', parse_date(name, 'f9.%y%j.%H%M')]
    when /^f10/ then                  ['f10', parse_date(name, 'f10.%y%j.%H%M')]
    when /^f11/ then                  ['f11', parse_date(name, 'f11.%y%j.%H%M')]
    when /^f12/ then                  ['f12', parse_date(name, 'f12.%y%j.%H%M')]
    when /^f13/ then                  ['f13', parse_date(name, 'f13.%y%j.%H%M')]
    when /^f14/ then                  ['f14', parse_date(name, 'f14.%y%j.%H%M')]
    when /^f15/ then                  ['f15', parse_date(name, 'f15.%y%j.%H%M')]
    when /^f16/ then                  ['f16', parse_date(name, 'f16.%y%j.%H%M')]
    when /^f17/ then                  ['f17', parse_date(name, 'f17.%y%j.%H%M')]
    when /^f18/ then                  ['f18', parse_date(name, 'f18.%y%j.%H%M')]
    when /^f19/ then                  ['f19', parse_date(name, 'f19.%y%j.%H%M')]
    when /^n2/ then                  ['n2', parse_date(name, 'n2.%y%j.%H%M')]
    when /^n3/ then                  ['n3', parse_date(name, 'n3.%y%j.%H%M')]
    when /^n4/ then                  ['n4', parse_date(name, 'n4.%y%j.%H%M')]
    when /^n5/ then                  ['n5', parse_date(name, 'n5.%y%j.%H%M')]
    when /^n6/ then                  ['n6', parse_date(name, 'n6.%y%j.%H%M')]
    when /^n7/ then                  ['n7', parse_date(name, 'n7.%y%j.%H%M')]
    when /^n8/ then                  ['n8', parse_date(name, 'n8.%y%j.%H%M')]
    when /^n9/ then                  ['n9', parse_date(name, 'n9.%y%j.%H%M')]
    when /^n10/ then                  ['n10', parse_date(name, 'n10.%y%j.%H%M')]
    when /^n11/ then                  ['n11', parse_date(name, 'n11.%y%j.%H%M')]
    when /^n12/ then                  ['n12', parse_date(name, 'n12.%y%j.%H%M')]
    when /^n13/ then                  ['n13', parse_date(name, 'n13.%y%j.%H%M')]
    when /^n14/ then                  ['n14', parse_date(name, 'n14.%y%j.%H%M')]
    when /^n15/ then                  ['n15', parse_date(name, 'n15.%y%j.%H%M')]
    when /^n16/ then                  ['n16', parse_date(name, 'n16.%y%j.%H%M')]
    when /^n17/ then                  ['n17', parse_date(name, 'n17.%y%j.%H%M')]
    when /^n18/ then                  ['n18', parse_date(name, 'n18.%y%j.%H%M')]
    when /^n19/ then                  ['n19', parse_date(name, 'n19.%y%j.%H%M')]
    when /^f16/ then                  ['f16', parse_date(name, 'f17.%y%j.%H%M')]
    when /^f17/ then                  ['f17', parse_date(name, 'f17.%y%j.%H%M')]
    when /^f18/ then                  ['f18', parse_date(name, 'f17.%y%j.%H%M')]
    when /^jpss1.\d{8}.\d{4}/ then    ['noaa20', parse_date(name, 'jpss1.%Y%m%d.%H%M')]
    else ['unknown', Time.now]
  end
  end

   def parse_date(filename, pattern)
      DateTime.strptime(filename, pattern)
    end

  def unknown?
	if @name=="unknown"
		return true
	else
		return false
	end
  end
end
