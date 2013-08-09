require 'nokogiri'
require 'yaml'

$input_file=ARGV[0]
doc = Nokogiri::HTML(open($input_file))

lib_version_hash={}
puts "processin deps"
doc.css('table.deps tbody')[0].css('tr').each {|tr| 

  lib_name = tr.css('td')[0].css('a')[0]['href'] 
  puts lib_name
  lib_version = tr.css('td')[1].css('a')[0].content 
  #  if lib_version_hash.has_key? lib_name then
  #	puts "already existed #{lib_name} #{lib_version_hash[lib_name]} => #{lib_version}"
  #  end
  lib_version_hash[lib_name]=lib_version
}

#puts lib_version_hash
#puts lib_version_hash.size

puts "processing conflicts"
# setting from conflicts list
doc.css('table.conflicts tbody')[0].css('tr').each { |tr|
  lib_name = tr.css('td')[0].css('a')[0]['href'] 
  selected_version = tr.css('td')[1].css('a')[0].content 
  lib_version_hash[lib_name]=selected_version
}
puts lib_version_hash
puts lib_version_hash.size

File.open($input_file+".yml","w"){|f| f.write(lib_version_hash.to_yaml)}
