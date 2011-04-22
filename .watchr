require 'term/ansicolor'

class Color
	extend Term::ANSIColor
end

watch('(app|config|db|lib|public|spec|vendor)/.*\.(rb|erb)') do |match|
	system("clear")
	puts Color.cyan{ "Found change in #{match[0].inspect}..." }
	system("rake spec")
end

