require 'json'
require 'json-compare'

class JsonWatch
	class << self
		attr_accessor :watch_list
		attr_accessor :notify_list

		def watch(name, options={}, &block)
			@watch_list ||= []
			notify = [options[:notify]].flatten
			exclude = [options[:exclude]].flatten
			@watch_list << {name: name, block: block, notify: notify, exclude: exclude}
		end

		def notify(name, options={}, &block)
			@notify_list ||= []
			@notify_list << {name: name, block: block}
		end
	end

	def initialize(options)
		@cache = options[:cache]
		@sleep = options[:sleep]
	end

	def start
		loop do
			watch_list.each do |watch|
				remember(watch[:name]) do |prev|
					curr = watch[:block].call
					args = [prev, curr, watch[:exclude]].compact
					diff = JsonCompare.get_diff(*args)
					notify(watch, diff) if diff != {}
					curr
				end
			end
			sleep @sleep
		end
	end

	def watch_list
		self.class.watch_list
	end

	def notify_list
		self.class.notify_list
	end

	def remember(name)
		if cached = @cache.get(name)
			prev = JSON.parse(cached)
		else
			prev = {}
		end
		curr = yield(prev)
		@cache.set(name, curr.to_json)
	end

	def notify(watch, diff)
		watch[:notify].each do |notify_name|
			notify = notify_list.find do |notify|
				notify[:name] == notify_name
			end
			notify[:block].call(watch, diff) if notify
		end
	end
end

