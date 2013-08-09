require 'yaml'
file_a=ARGV[0]
file_b=ARGV[1]
hash_a=YAML.load(open(file_a))
hash_b=YAML.load(open(file_b))

hash_a.each{ |k,v|
  if not hash_b.has_key? k then
     puts "[new added] #{file_a}[#{k}]=#{v}  --- #{file_b}[#{k}]=#{hash_b[k]}"
  elsif hash_b[k]!=v then
     puts "[diff] #{file_a}[#{k}]=#{v}  --- #{file_b}[#{k}]=#{hash_b[k]}"
  end
}
