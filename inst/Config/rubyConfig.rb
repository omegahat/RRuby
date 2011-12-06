#/usr/local/bin/ruby
Config::CONFIG.keys.sort_by{|k| k.upcase}.each do |k|
  puts "#{k}: #{Config::CONFIG[k]}"
end
