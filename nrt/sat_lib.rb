# frozen_string_literal: true
require "date"

class Satellite
  attr_reader :name
  attr_reader :acquired_at

  def initialize(pattern)
    @name, @acquired_at = parse_name(File.basename(pattern))
  end

  def archive_path
    "UAFGINA/#{@name}/#{@acquired_at.strftime('%Y/%03j')}/"
  end

  def parse_name(filename)
    name = filename.downcase
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
    when /^n15/ then                  ['noaa15', parse_date(name, 'n15.%y%j.%H%M')]
    when /^n18/ then                  ['noaa18', parse_date(name, 'n18.%y%j.%H%M')]
    when /^n19/ then                  ['noaa19', parse_date(name, 'n19.%y%j.%H%M')]
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
