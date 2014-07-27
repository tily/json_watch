# JsonWatch

small utility to watch json changes

## Installation

Add this line to your application's Gemfile:

    gem 'json_watch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_watch

## Usage

### Simple Example

save this to `simple_watch.rb`:

	class SimpleWatch < JsonWatch
	        watch :time, notify: :stdout do
	                {'time' => Time.now}
	        end
	
	        notify :stdout do |watch, diff|
	                STDOUT.puts "#{watch[:name]}: #{diff.to_json}"
	        end
	end
	
	watch = SimpleWatch.new(cache: Redis.new, sleep: 1)
	watch.start

and execute:

	~/dev/json_watch# ruby simple_watch.rb
	time: {"append":{"time":"2014-07-27 13:36:42 +0900"}}
	time: {"update":{"time":"2014-07-27 13:36:43 +0900"}}
	time: {"update":{"time":"2014-07-27 13:36:44 +0900"}}
	time: {"update":{"time":"2014-07-27 13:36:45 +0900"}}
	time: {"update":{"time":"2014-07-27 13:36:46 +0900"}}

## Contributing

1. Fork it ( https://github.com/[my-github-username]/json_watch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
