
watch('[app|config|db|lib|public|spec|vendor]/.*\.[rb|erb]') do |match|
	# puts "Found change in #{match[0].inspect}..."
	system("rake spec")
end

