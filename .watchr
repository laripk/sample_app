
watch('[app|config|db|lib|public|spec|vendor]/.*\.[rb|erb]') do |match|
	system("clear")
	puts "Found change in #{match[0].inspect}..."
	system("rake spec")
end

